package co.kr.TheTravelSpring;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.*;
import java.util.*;
import java.sql.Connection;

import org.springframework.beans.factory.annotation.Autowired;
import org.apache.ibatis.executor.BatchResult;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;//MyBatis

import model.review.*;
import util.PageTest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;

@Controller
@RequestMapping(value = "/review")
public class ReviewController {
	
	@Autowired //setter작업이 자동으로 된다 
	private SqlSession sqlSession;//변수 MyBatis 사용하려고 
	
	
	//list 뷰
	@RequestMapping(value = "/list.do", method = RequestMethod.GET)
	public String reviewList(@RequestParam(value="pro_no",required=false)String pro_no, Model model, 
			@RequestParam(value="pageNum",required=false)String pageNum, HttpServletRequest request) {	
		if(pageNum==null) {
			pageNum="1";
		}
		
		int cnt=sqlSession.selectOne("review.selectCount");//총 글갯수 얻기 
		int curPage=Integer.parseInt(pageNum);//현재 페이지 
		
		PageTest pp2=new PageTest(cnt,curPage);//객체 생성 ,생성자 호출 ,페이지 처리 ***
		pp2.setPageSize(12);
		
		int startPos=pp2.getStartRow()-1;//***
		 
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("pro_no", pro_no);
		map.put("start", new Integer(startPos));
		map.put("count", new Integer(pp2.getPageSize()));//10개씩
		
		List<ReviewDto> boardList;
		
		if(pro_no == null) {
			boardList= sqlSession.selectList("review.selectListAll",map);
		}else {
			boardList = sqlSession.selectList("review.selectListPro",map);
		}
		 
		List<ReviewImgDto> imgList = new ArrayList<ReviewImgDto>();
		
		for (ReviewDto reviewDto : boardList) {
			imgList.add((ReviewImgDto)sqlSession.selectOne("review.selectImgList",reviewDto.getReview_id()));
		}
		
		//에러처리 
	    if(pp2.getEndPage()>pp2.getPageCnt()) {
	    	pp2.setEndPage(pp2.getPageCnt());
	    }
		
		int number=cnt-(curPage-1)*pp2.getPageSize();//글번를 역순으로 
		
		model.addAttribute("number",number);//글번호
		model.addAttribute("pageNum",pageNum);//페이지 번호
		model.addAttribute("pro_no",pro_no);//jsp에서 사용할 데이터 
		model.addAttribute("pp2",pp2);
		model.addAttribute("count",cnt);//총글갯수
		model.addAttribute("boardList",boardList);//jsp에서 사용할 데이터 
		model.addAttribute("imgList",imgList);//jsp에서 사용할 데이터 
		 
		
		return ".main.review.list";//뷰리턴 list.jsp
	}//reviewList() - end
	
	@RequestMapping(value = "/writeForm.do", method = RequestMethod.POST)
	public String writeForm(HttpServletRequest request, Model model ) {
		String pro_name=request.getParameter("pro_name");
		String pro_no=request.getParameter("pro_no");
		
		String user_id = request.getParameter("userId");		
		String pageNum = request.getParameter("pageNum");
		
		String review_id = user_id + "@" + pro_no;
		
		model.addAttribute("review_id", review_id);
		model.addAttribute("pro_name", pro_name);
		model.addAttribute("pro_no", pro_no);
		model.addAttribute("pageNum", pageNum);
		
		List<ReviewDto> listChk=
				sqlSession.selectList("review.selectOne",review_id);
		
		if(listChk.isEmpty()){
			return ".main.review.writeForm";
		}else {
			return ".main.review.updateForm";
		}
	}
	
	@RequestMapping(value = "/writePro.do", method = RequestMethod.POST)
	public String writePro(@ModelAttribute("ReviewDto") ReviewDto reviewDto, HttpServletRequest request, Model model) throws Exception {

		String real_Path =  request.getSession().getServletContext().getRealPath("/");
		String upload_Path = real_Path+"/resources/imgs/review/saveImg/";
		
		final MultipartHttpServletRequest mulRequest = (MultipartHttpServletRequest) request;
		
		List<MultipartFile> fileList = mulRequest.getFiles("file");
		String review_id = mulRequest.getParameter("review_id");	
		
		int idx = 0;
		for (MultipartFile mf : fileList) {
			
			int k = -1;
			ReviewImgDto reImgDto = new ReviewImgDto();
			String orignalFileName =  mf.getOriginalFilename();
					
			k = orignalFileName.lastIndexOf("."); // 파일 확장자 위치	
			if(k>0) {
			String newFileNamd = review_id +"_"+ (idx) + orignalFileName.substring(k, orignalFileName.length()); 
			
            String safeFile = upload_Path + orignalFileName;
            String changeFile = upload_Path + newFileNamd;
            
            mf.transferTo(new File(safeFile));// 파일 저장
            File oldFile = new File(safeFile);
		    File newFile = new File(changeFile);
		    oldFile.renameTo(newFile);
		    
		    reImgDto.setImg_id(review_id);
		    reImgDto.setImg_lvl(idx);
		    reImgDto.setImg_name(newFileNamd);
		    
		    sqlSession.insert("review.insertImgReview",reImgDto);
			}
		    idx++;
		}// for - end
		
		model.addAttribute("pro_no", reviewDto.getPro_no());
		
		sqlSession.insert("review.insertReview",reviewDto);
		return "redirect:/review/list.do";
	}
	
	@RequestMapping(value = "/detail.do", method = RequestMethod.POST)
	public String detail(String review_id, String pageNum, Model model) {		
		
		ReviewDto reDto = sqlSession.selectOne("review.selectOne", review_id);
		List<ReviewImgDto> img_list = sqlSession.selectList("review.selectImgDetail", review_id);
		
		model.addAttribute("reviewDto", reDto);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("img_list", img_list);
		
		
		return ".main.review.detail";
	}
	
	@RequestMapping(value = "/deleteForm.do", method = RequestMethod.POST)
	public String delete(String pro_no, String pageNum, String review_id, Model model, HttpServletRequest request) {
		List<ReviewImgDto> img_list = sqlSession.selectList("review.selectImgDetail", review_id);
		
		String real_Path =  request.getSession().getServletContext().getRealPath("/");
		String upload_Path = real_Path+"/resources/imgs/review/saveImg/";
		
		
		for (ReviewImgDto reviewImgDto : img_list) {
			File f = new File(upload_Path+reviewImgDto.getImg_name());
			if(f.isFile()) {
				f.delete();
			}
		}
		
		model.addAttribute("pro_no",pro_no);
		
		sqlSession.delete("review.reviewDelete", review_id);
		sqlSession.delete("review.reviewImgDelete", review_id);
		
		
		
		return "redirect:/review/list.do";
	}
	
	
}//class - end

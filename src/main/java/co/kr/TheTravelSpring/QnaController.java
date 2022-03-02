package co.kr.TheTravelSpring;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.*;
import util.PageTest;
import org.springframework.beans.factory.annotation.Autowired;
import org.apache.commons.io.FilenameUtils;
import org.apache.ibatis.session.SqlSession;

import model.qna.QnaDto;
import model.member.MemberDto;

import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;

@Controller
@RequestMapping("/qna")
public class QnaController {

	@Autowired //setter 작업이 자동으로 된다.
	private SqlSession sqlSession; //변수 MyBatis 사용하려고
	
	//글쓰기 폼, 답글쓰기 폼
	@RequestMapping("/writeForm.do")
	public String writeForm(Model model,String num,
			String ref,String re_step,String re_level,String pageNum){
		
		if(num==null) {//원글쓰기
			num="0"; //글번호
			ref="1"; //글 그룹
			re_step="0"; //글 순서
			re_level="0"; //글 깊이
		}
		
		model.addAttribute("pageNum",pageNum);
		model.addAttribute("num",new Integer(num));
		model.addAttribute("ref",new Integer(ref));
		model.addAttribute("re_step",new Integer(re_step));
		model.addAttribute("re_level",new Integer(re_level));
		
		//return "/qna/writeForm"; //뷰 리턴 views/board/writeForm.jsp
		return ".main.qna.writeForm";
		
	}
	
	//DB글쓰기
	@RequestMapping(value="writePro.do",method=RequestMethod.POST)
	public String writePro(@ModelAttribute("qnaDto") QnaDto qnaDto, HttpServletRequest request) throws IOException {
		
		String real_Path =  request.getSession().getServletContext().getRealPath("/");
		String upload_Path = real_Path+"/resources/imgs/qna/saveImg/";
		
		int maxNum=0; //최대 글번호 넣을 갯수
		if(sqlSession.selectOne("qna.qnaNumMax") != null) {
			//최대 글번호가 null 아니면
			maxNum=sqlSession.selectOne("qna.qnaNumMax");
		}
		
		if(maxNum != 0) {
			maxNum=maxNum+1;//답글 그룹으로 사용할 것임
		} else { //처음 글이면
			maxNum=1;
		}
		
		
		if(qnaDto.getNum() != 0) {//답글이면
			//답글 끼워넣기 위치 확보
			sqlSession.update("qna.qnaReStep",qnaDto);
			
			qnaDto.setRe_step(qnaDto.getRe_step()+1); //글순서
			qnaDto.setRe_level(qnaDto.getRe_level()+1); //글 레벨
		
		
		} else { //원글이면
			qnaDto.setRef(new Integer(maxNum));//글 그룹
			qnaDto.setRe_step(new Integer(0));
			qnaDto.setRe_level(new Integer(0));
		}
		
		String fileName=null;
		MultipartFile uploadFile = qnaDto.getUploadFile();
		
		if (!uploadFile.isEmpty()) {
			String originalFileName = uploadFile.getOriginalFilename();
			String ext = FilenameUtils.getExtension(originalFileName);	//확장자 구하기
			UUID uuid = UUID.randomUUID();	//UUID 구하기
			fileName=uuid+"."+ext;
			uploadFile.transferTo(new File(upload_Path + fileName));
		}
		qnaDto.setFileName(fileName);
		
		sqlSession.insert("qna.insertQna",qnaDto); //글쓰기
		return "redirect:/qna/list.do";
	}
	
	//리스트
	@RequestMapping("list.do")
	public String listBoard(@ModelAttribute("qnaDto") QnaDto qnaDto, Model model,
			String pageNum, String searchText, String category,
			HttpServletRequest request) {
		if(pageNum==null) {
			pageNum="1";
		}
		
		int cnt=sqlSession.selectOne("qna.qnaCount"); //총 글갯수 얻기
		int curPage=Integer.parseInt(pageNum); //현재 페이지
		
		PageTest pp2=new PageTest(cnt,curPage); //페이지 처리 PageTest.java에서 생성자 호출 객체 생성
		
		
		//
		int startPos=pp2.getStartRow()-1; //
		Map<String,Object> map=new HashMap<String,Object>();
		
		map.put("category", "%"+category+"%");
		map.put("searchText", "%"+searchText+"%");
		map.put("start",new Integer(startPos));
		map.put("count",new Integer(pp2.getPageSize())); //10개씩
		
		
		

		//이제 map을 넘겨줘야함
		List<QnaDto> list=sqlSession.selectList("qna.selectQnaList",map);
		if(searchText != null) {
				list=sqlSession.selectList("qna.searchQnaList",map);				
		}
			
			
		
			
		/*
		
		
		<c:if test="${pp2.endPage>pp2.pageCount}">
			<c:set var="${pp2.endPage}" value="${pp2.pageCount}"/>
		</c:if>
		*/
		
		int number=cnt-(curPage-1)*pp2.getPageSize(); //글번호 역순으로
		 
		//int number=1;
		//int number=cnt-(pp2.getCurPage()*pp2.getPageSize()); //글번호 역순으로
		
		//에러처리 에러처리 방지
		if(pp2.getEndPage()>pp2.getPageCnt()) {
			pp2.setEndPage(pp2.getPageCnt());
		}
		
		
		model.addAttribute("number",number);
		model.addAttribute("pageNum",pageNum);
		model.addAttribute("searchText",searchText);
		model.addAttribute("category",category);
		
		
		model.addAttribute("pp2",pp2);
		model.addAttribute("cnt",cnt); //총 글 갯수
		model.addAttribute("list",list); //jsp에서 사용할 데이터
		//return "/qna/list"; //뷰 리턴 list.jsp
		return ".main.qna.list";
	}
	
	@RequestMapping(value = "fileDownload.do")
    public void fileDownload4(HttpServletRequest request,HttpServletResponse response) throws Exception {

		String real_Path =  request.getSession().getServletContext().getRealPath("/");
		String upload_Path = real_Path+"/resources/imgs/qna/saveImg/";
        
        String filename =request.getParameter("fileName");
        String realFilename="";
         
        try {
            String browser = request.getHeader("User-Agent"); 
            //파일 인코딩 
            if (browser.contains("MSIE") || browser.contains("Trident")
                    || browser.contains("Chrome")) {
                filename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+",
                        "%20");
            } else {
                filename = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
            }
        } catch (UnsupportedEncodingException ex) {
        }
        realFilename = upload_Path + filename;
        File file1 = new File(realFilename);
        if (!file1.exists()) {
            return ;
        }
        
        // 파일명 지정        
        response.setContentType("application/octer-stream");
        response.setHeader("Content-Transfer-Encoding", "binary;");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
        try {
            OutputStream os = response.getOutputStream();
            FileInputStream fis = new FileInputStream(realFilename);
 
            int ncount = 0;
            byte[] bytes = new byte[512];
 
            while ((ncount = fis.read(bytes)) != -1 ) {
                os.write(bytes, 0, ncount);
            }
            fis.close();
            os.close();
        } catch (Exception e) {
            System.out.println("FileNotFoundException : " + e);
        }
    }
	
	
	//조회수 증가, 글내용 보기
	@RequestMapping("content.do")
	public String contentPro(Model model,String num,String pageNum) {
		
		int num1=Integer.parseInt(num);
		
		sqlSession.update("qna.qnaReadcount",num1); //조회수 증가
		
		QnaDto qDto=sqlSession.selectOne("qna.selectOneQna",num1);
		
		model.addAttribute("num",num1);
		model.addAttribute("pageNum",pageNum);
		model.addAttribute("qDto",qDto); //jsp에서 사용할 데이터
		
		//return "/qna/content"; //뷰리턴 content.jsp
		return ".main.qna.content";
	}
	
	//글수정 폼
	@RequestMapping("updateForm.do")
	public ModelAndView updateForm(String num,String pageNum) {
		
		int num1=Integer.parseInt(num);
		
		QnaDto qDto=sqlSession.selectOne("qna.selectOneQna",num1);
		
		ModelAndView mv=new ModelAndView();
		mv.addObject("pageNum",pageNum);
		mv.addObject("num",num1);
		mv.addObject("qDto",qDto);
		mv.setViewName(".main.qna.updateForm"); //뷰 이름
		
		return mv; //*********
	}
	
	//DB 글 수정
	@RequestMapping(value="updatePro.do",method=RequestMethod.POST)
	public ModelAndView updatePro(QnaDto qnaDto,String pageNum, HttpServletRequest request) throws IOException {
		
		String real_Path =  request.getSession().getServletContext().getRealPath("/");
		String upload_Path = real_Path+"/resources/imgs/qna/saveImg/";
				
		String fileName=null;
		MultipartFile uploadFile = qnaDto.getUploadFile();
		
		if (!uploadFile.isEmpty()) {
			String originalFileName = uploadFile.getOriginalFilename();
			String ext = FilenameUtils.getExtension(originalFileName);	//확장자 구하기
			UUID uuid = UUID.randomUUID();	//UUID 구하기
			fileName=uuid+"."+ext;
			uploadFile.transferTo(new File(upload_Path + fileName));
		}
		qnaDto.setFileName(fileName);
		
		sqlSession.update("qna.updateQna",qnaDto);//글 수정
		
		ModelAndView mv=new ModelAndView();
		mv.addObject("pageNum",pageNum);
		mv.setViewName("redirect:/qna/list.do"); //URL 주소
		//response.sendRedirect("list.jsp");		
		return mv;
	}
	
	//DB글삭제 폼
	@RequestMapping("deleteForm.do")
	public ModelAndView deleteForm(String num,String pageNum) {
		
		int num1=Integer.parseInt(num);
		
		QnaDto qDto=sqlSession.selectOne("qna.selectOneQna",num1);
		
		ModelAndView mv=new ModelAndView();
		mv.addObject("pageNum",pageNum);
		mv.addObject("num",num1);
		mv.addObject("qDto",qDto);
		mv.setViewName(".main.qna.deleteForm"); //뷰 이름
		
		return mv; //*********
	}
	
	//DB글삭제
	@RequestMapping("delete.do")
	public String deletePro(Model model,String num,String pageNum) {
		sqlSession.delete("qna.deleteQna",new Integer(num));
		model.addAttribute("pageNum",pageNum);
		
		return "redirect:../qna/list.do";
	}
	
}//class

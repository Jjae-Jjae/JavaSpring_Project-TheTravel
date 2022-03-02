package co.kr.TheTravelSpring;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.*;
import java.util.Locale.Category;

import util.PageTest;
import org.springframework.beans.factory.annotation.Autowired;
import org.apache.ibatis.session.SqlSession;

import model.faq.FaqDto;
import model.member.MemberDto;

import javax.servlet.http.HttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;

@Controller
@RequestMapping("/faq")
public class FaqController {

	@Autowired //setter 작업이 자동으로 된다.
	private SqlSession sqlSession; //변수 MyBatis 사용하려고
	
	//글쓰기 폼, 답글쓰기 폼
	@RequestMapping("/writeForm.do")
	public String writeForm(Model model,String num,
			//String ref,String re_step,String re_level,
			String pageNum
			) {
		
		if(num==null) {//원글쓰기
			num="0"; //글번호
			//ref="1"; //글 그룹
			//re_step="0"; //글 순서
			//re_level="0"; //글 깊이
		}
		
		model.addAttribute("pageNum",pageNum);
		model.addAttribute("num",new Integer(num));
		//model.addAttribute("ref",new Integer(ref));
		//model.addAttribute("re_step",new Integer(re_step));
		//model.addAttribute("re_level",new Integer(re_level));
		
		//return "/qna/writeForm"; //뷰 리턴 views/board/writeForm.jsp
		return ".main.faq.writeForm";
		
	}
	
	//DB글쓰기
	@RequestMapping(value="writePro.do",method=RequestMethod.POST)
	public String writePro(@ModelAttribute("faqDto") FaqDto faqDto,
			HttpServletRequest request) {
		int maxNum=0; //최대 글번호 넣을 갯수
		if(sqlSession.selectOne("faq.faqNumMax") != null) {
			//최대 글번호가 null 아니면
			maxNum=sqlSession.selectOne("faq.faqNumMax");
		}
		
		if(maxNum != 0) {
			maxNum=maxNum+1;//답글 그룹으로 사용할 것임
		} else { //처음 글이면
			maxNum=1;
		}
		
		/*
		if(faqDto.getNum() != 0) {//답글이면
			//답글 끼워넣기 위치 확보
			sqlSession.update("qna.qnaReStep",faqDto);
			
			faqDto.setRe_step(faqDto.getRe_step()+1); //글순서
			faqDto.setRe_level(faqDto.getRe_level()+1); //글 레벨
		
		
		} else { //원글이면
		
			faqDto.setRef(new Integer(maxNum));//글 그룹
			faqDto.setRe_step(new Integer(0));
			faqDto.setRe_level(new Integer(0));
		}*/
		
		sqlSession.insert("faq.insertFaq",faqDto); //글쓰기
		return "redirect:/faq/list.do";
	}
	
	//리스트
	@RequestMapping("list.do")
	public String listBoard(@ModelAttribute("faqDto") FaqDto faqDto, Model model,
			String pageNum, String searchText, String category,
			HttpServletRequest request) {
		if(pageNum==null) {
			pageNum="1";
		}
		
		int cnt=sqlSession.selectOne("faq.faqCount"); //총 글갯수 얻기
		int curPage=Integer.parseInt(pageNum); //현재 페이지
		
		PageTest pp2=new PageTest(cnt,curPage); //페이지 처리 PageTest.java에서 생성자 호출 객체 생성
		
		
		
		//
		int startPos=pp2.getStartRow()-1; //***
		Map<String,Object> map=new HashMap<String,Object>();
		
		map.put("category", "%"+category+"%");
		map.put("searchText", "%"+searchText+"%");
		map.put("start",new Integer(startPos));
		map.put("count",new Integer(pp2.getPageSize())); //10개씩
		

		//이제 map을 넘겨줘야함
		List<FaqDto> list=sqlSession.selectList("faq.selectFaqList",map);
		if(searchText!=null) {
			list=sqlSession.selectList("faq.searchFaqList",map);
		}
		/*
		
		
		<c:if test="${pp2.endPage>pp2.pageCount}">
			<c:set var="${pp2.endPage}" value="${pp2.pageCount}"/>
		</c:if>
		*/
		
		int number=cnt-(curPage-1)*pp2.getPageSize(); //글번호 역순으로
		//int number=cnt-(pp2.getCurPage()*pp2.getPageSize()); //글번호 역순으로
		
		//에러처리 에러처리 방지
		if(pp2.getEndPage()>pp2.getPageCnt()) {
			pp2.setEndPage(pp2.getPageCnt());
		}
		
		//검색
		
		
		
		model.addAttribute("number",number);
		model.addAttribute("pageNum",pageNum);
		
		model.addAttribute("category",category);
		model.addAttribute("searchText",searchText);
		model.addAttribute("pp2",pp2);
		model.addAttribute("cnt",cnt); //총 글 갯수
		model.addAttribute("list",list); //jsp에서 사용할 데이터
		//return "/qna/list"; //뷰 리턴 list.jsp
		return ".main.faq.list";
	}
	
	//조회수 증가, 글내용 보기
	@RequestMapping("content.do")
	public String contentPro(Model model,String num,String pageNum) {
		
		int num1=Integer.parseInt(num);
		
		sqlSession.update("faq.faqReadCount",num1); //조회수 증가
		
		FaqDto fDto=sqlSession.selectOne("faq.selectOneFaq",num1);
		
		model.addAttribute("num",num1);
		model.addAttribute("pageNum",pageNum);
		model.addAttribute("fDto",fDto); //jsp에서 사용할 데이터
		
		//return "/faq/content"; //뷰리턴 content.jsp
		return ".main.faq.content";
	}
	
	//글수정 폼
	@RequestMapping("updateForm.do")
	public ModelAndView updateForm(String num,String pageNum) {
		
		int num1=Integer.parseInt(num);
		
		FaqDto fDto=sqlSession.selectOne("faq.selectOneFaq",num1);
		
		ModelAndView mv=new ModelAndView();
		mv.addObject("pageNum",pageNum);
		mv.addObject("num",num1);
		mv.addObject("fDto",fDto);
		mv.setViewName(".main.faq.updateForm"); //뷰 이름
		
		return mv; //*********
	}
	
	//DB 글 수정
	@RequestMapping(value="updatePro.do",method=RequestMethod.POST)
	public ModelAndView updatePro(FaqDto faqDto,String pageNum) {
		sqlSession.update("faq.updateFaq",faqDto);//글 수정
		
		ModelAndView mv=new ModelAndView();
		mv.addObject("pageNum",pageNum);
		mv.setViewName("redirect:/faq/list.do"); //URL 주소
		//response.sendRedirect("list.jsp");		
		return mv;
	}
	
	//DB 글 삭제
	@RequestMapping("deleteForm.do")
	public ModelAndView deleteForm(String num,String pageNum) {
		
		int num1=Integer.parseInt(num);
		
		FaqDto fDto=sqlSession.selectOne("faq.selectOneFaq",num1);
		
		ModelAndView mv=new ModelAndView();
		mv.addObject("pageNum",pageNum);
		mv.addObject("num",num1);
		mv.addObject("fDto",fDto);
		mv.setViewName(".main.faq.deleteForm"); //뷰 이름
		
		return mv; //*********
	}
	
	//DB글삭제
	@RequestMapping("deletePro.do")
	public String deletePro(Model model,String num,String pageNum) {
		sqlSession.delete("faq.deleteFaq",new Integer(num));
		model.addAttribute("pageNum",pageNum);
		
		return "redirect:/faq/list.do";
	}
	
	
}//class

package co.kr.TheTravelSpring;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.apache.ibatis.session.SqlSession;//MyBatis

import model.member.MemberDto;
import model.notice.NoticeDto;
import model.notice.NoticeSearchDto;

import javax.servlet.http.HttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;

import util.PageTest;

@RequestMapping("/notice")
@Controller
public class NoticeController {

	@Autowired
	private SqlSession sqlSession;
	
	//리스트
	@RequestMapping("list.do")
	public String listNotice(@ModelAttribute("noticeSearchDto") NoticeSearchDto noticeSearchDto, Model model) {
		
		//1. 파라미터 받기 
		String category = noticeSearchDto.getCategory();
		String searchText = noticeSearchDto.getSearchText();
		String pageNum = noticeSearchDto.getPageNum();
		
		if (pageNum == null) {
			pageNum = "1";
		}
		if (category == null) {
			category = "";
		}
		if(searchText == null) {
			searchText ="";
		}
		
		// 2. 처리 - 글갯수 조회	
		Map<String, Object> map = new HashMap<String, Object>();	
		map.put("category", "%" + category + "%");
		map.put("searchText", "%" + searchText + "%");
		
		int cnt = sqlSession.selectOne("notice.selectCount", map);
		
		//2. 처리 - 목록 데이터 조회	
		PageTest pageObj = new PageTest(cnt, Integer.parseInt(pageNum)); //페이지 처리
		
		map.put("start", new Integer(pageObj.getStartRow()-1));
		map.put("count", new Integer(pageObj.getPageSize())); ///10개씩
		
		List<NoticeDto> list = sqlSession.selectList("notice.selectListNotice", map);		
		
		if(pageObj.getEndPage()> pageObj.getPageCnt() ) {
			pageObj.setEndPage(pageObj.getPageCnt());
		}
		
		//3. 화면으로 값 리턴
		noticeSearchDto.setCategory(category);
		noticeSearchDto.setSearchText(searchText);
		
		model.addAttribute("cnt", cnt);
		model.addAttribute("cnt", cnt);
		model.addAttribute("sdto", noticeSearchDto);
		model.addAttribute("pdto", pageObj);
		model.addAttribute("list", list);
		
		return ".main.notice.list";
	}
	
	//글내용 보기, 조회수 증가
	@RequestMapping("content.do")
	public String contentNotice(Model model, String num, String pageNum) {
		//1. 파라미터 받기
		int numVal = Integer.parseInt(num);
		
		//2. 조회수 증가 처리
		sqlSession.update("notice.updateReadCount", numVal);			
		
		//2. 내용 가져오기
		NoticeDto dto = sqlSession.selectOne("notice.selectOneNotice", numVal);
		
		//3. 화면으로 값 리턴
		model.addAttribute("num", num);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("dto", dto);
		
		return ".main.notice.content";		
	}
	
	//글 삭제
	@RequestMapping("delete.do")
	public String deleteNotice(Model model, String num, String pageNum) {
		sqlSession.delete("notice.deleteNotice", new Integer(num));
		model.addAttribute("pageNum", pageNum);
		return "redirect:/notice/list.do";
	}
	
	//글수정 폼
	@RequestMapping("updateForm.do")
	public ModelAndView updateFormNotice(String num, String pageNum) {
		int numVal = Integer.parseInt(num);
		
		NoticeDto dto = sqlSession.selectOne("notice.selectOneNotice", numVal);
		
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("num", numVal);
		mv.addObject("pageNum", pageNum);
		mv.addObject("dto", dto);
		mv.setViewName(".main.notice.updateForm");//뷰
		
		return mv; 	
	}
	
}

package co.kr.TheTravelSpring;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.apache.ibatis.session.SqlSession;//MyBatis
import model.member.MemberDto;
import model.qna.QnaDto;
import util.PageTest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private SqlSession sqlSession;//변수
	
	@RequestMapping("/insertForm.do")	
	public String insertForm() {
		//return "/member/insertForm";//insertForm.jsp 뷰 리턴
		return ".main.member.insertForm";//insertForm.jsp 뷰 리턴
		//views/member/insertForm.jsp
	}
	
	//id중복 체크
	@RequestMapping(value="/idCheck.do", method=RequestMethod.POST)
	public String idCheck(String id, Model model) {
		
		int check=-1;//변수 -1일때는 사용 중인 id
		
		MemberDto mDto = sqlSession.selectOne("member.selectOne", id);
		if(mDto==null) {
			check=1;//사용가능한id
		}
		model.addAttribute("check", check);
		return "/member/idCheck";//idCheck.jsp 뷰 리턴
	}//id중복 체크 - end
	
	//회원가입
	@RequestMapping(value="/insertPro.do", method=RequestMethod.POST)
	public String memberInsert(@ModelAttribute("memberDto") MemberDto memberDto, HttpServletRequest request) {
		
		String email = request.getParameter("email");
		String email2 = request.getParameter("email2");
		email = email + email2;
		memberDto.setEmail(email);
		
		String tel=request.getParameter("tel");
		String tel2=request.getParameter("tel2");
		String tel3=request.getParameter("tel3");
		tel = tel+"-"+tel2+"-"+tel3;
		memberDto.setTel(tel);
		
		sqlSession.insert("member.insertMember", memberDto);//회원가입
		//return "/member/loginForm";//뷰 리턴, loginForm.jsp
		return "redirect:/member/login.do";//뷰 리턴, loginForm.jsp
	}//회원가입 - end
	
	//로그인 폼
	@RequestMapping("/login.do")
	public String loginF() {
		//return "/member/loginForm";//뷰리턴 loginForm.jsp
		return ".main.member.loginForm";//뷰리턴 loginForm.jsp
	}//로그인 폼 - end
	
	//로그인
	@RequestMapping(value="/loginPro.do", method=RequestMethod.POST)
	public String loginP(String id, String pw, Model model) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("pw", pw);
		
		MemberDto mdto = sqlSession.selectOne("member.selectLogin", map);
		
		if(mdto==null) {
			model.addAttribute("msg","로그인 실패");
			//return "/member/loginForm"; //뷰리턴 loginForm.jsp
			return ".main.member.loginForm"; //뷰리턴 loginForm.jsp
		}
		
		//정상적으로 로그인 된 경우
		model.addAttribute("mdto", mdto);
		//return "/member/loginSuccess";//뷰리턴, loginSuccess.jsp
		return ".main.member.loginSuccess";//뷰리턴, loginSuccess.jsp
	}//로그인 - end
	
	//로그아웃
	@RequestMapping("/logOut.do")
	public String logOut() {
		//return "/member/logOut"; //뷰리턴 logout.jsp
		return ".main.member.logOut"; //뷰리턴 logout.jsp
	}//로그아웃 - end
	
	//내정보 폼
	@RequestMapping(value = "/myPageForm.do")
	public String myPageForm(HttpServletRequest request, Model model) throws Exception{
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("userId");
		
		MemberDto mdto = sqlSession.selectOne("member.selectOne", id);
		model.addAttribute("mdto",mdto);
		
		return ".main.member.myPageForm";
	}//내정보 폼 - end
	
	//회원 정보 수정 폼
	@RequestMapping(value="/editForm.do")
	public String editF(HttpServletRequest request, Model model) throws Exception{
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("userId");
		MemberDto mdto = sqlSession.selectOne("member.selectOne", id);
		
		String emailTemp = mdto.getEmail();		
		int idx = emailTemp.indexOf("@");
		String email = emailTemp.substring(0, idx);//park@daum.net =>park
		String email2 = emailTemp.substring(idx+1); //@ daum.net
		
		String telTemp = mdto.getTel();//01023235656
		String[] array = telTemp.split("-");
		String tel = array[0];
		String tel2 = array[1];
		String tel3 = array[2];
		
		model.addAttribute("email",email);
		model.addAttribute("email2",email2);
		model.addAttribute("tel",tel);
		model.addAttribute("tel2",tel2);
		model.addAttribute("tel3",tel3);
		
		model.addAttribute("mdto",mdto);
		
		//return "/member/editForm";//뷰리턴 editForm.jsp
		return ".main.member.editForm";//뷰리턴 editForm.jsp
	}//회원 정보 수정 폼 - end
	
	//DB회원 정보 수정
	@RequestMapping(value="/editPro.do", method=RequestMethod.POST)
	public String edtiP(@ModelAttribute("memberDto") MemberDto memberDto, HttpServletRequest request) {
		String email = request.getParameter("email");
		String email2 = request.getParameter("email2");
		email = email + email2;
		memberDto.setEmail(email);
		
		String tel = request.getParameter("tel");
		String tel2 = request.getParameter("tel2");
		String tel3 = request.getParameter("tel3");
		tel = tel+"-"+tel2+"-"+tel3;
		memberDto.setTel(tel);
		sqlSession.update("member.memberUpdate", memberDto);//수정
		
		 //return "main";//뷰리턴 views/main.jsp
		 return ".main.member.editPro";
	}//DB회원 정보 수정 - end
	
	//암호 변경 Form
	@RequestMapping(value = "/pwChangeForm.do")
	public String pwChangeForm(HttpServletRequest request, Model model) throws Exception{
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("userId");
		
		MemberDto mdto = sqlSession.selectOne("member.selectOne", id);
		model.addAttribute("pw",mdto.getPw());
		
		return ".main.member.pwChangeForm";
	}//암호 변경 Form - end
	
	//암호변경 로직
	@RequestMapping(value = "/pwChangePro.do")
	public String pwChangePro(String pw2, String id) {
		
		MemberDto memberDto = new MemberDto();
		memberDto.setPw(pw2);
		memberDto.setId(id);
		
		sqlSession.update("member.memberPwUpdate", memberDto);
				
		return ".main.member.pwChangePro";
	}//암호변경 로직 - end
	
	//회원탈퇴 Form
	@RequestMapping(value = "/deleteForm.do")
	public String delForm(){
		return ".main.member.deleteForm";
	}//회원탈퇴 Form - end
	
	//회원탈퇴
	@RequestMapping(value = "/deletePro.do")
	public String deletePro(String id, String pw, Model model) {
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("id", id);
			map.put("pw", pw);
			
			MemberDto mdto = sqlSession.selectOne("member.selectLogin", map);
			
			if(mdto==null) {
				model.addAttribute("msg","비밀번호 틀림");
				//return "/member/loginForm"; //뷰리턴 loginForm.jsp
				return ".main.member.deleteForm"; //뷰리턴 loginForm.jsp
			}
			
		sqlSession.delete("member.memberDelete", id);
		//return "main";//뷰리턴 main.jsp
		return ".main.member.logOut";
	}//회원탈퇴 - end
	
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ admin @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	//adminList
	@RequestMapping(value = "/adminList.do")
	public String adminlist(@RequestParam(value="searchText",required=false)String searchText,
		@RequestParam(value="column",required=false)String column,
		String pageNum, Model model,
		HttpServletRequest request) {
	if(pageNum==null) {
		pageNum="1";
	}
	
	int cnt;
	Map<String,Object> map=new HashMap<String,Object>();
	
	if(searchText == "" || searchText == null ){
		cnt=sqlSession.selectOne("member.selectCount"); //총 글갯수 얻기
	}else {
		map.put("column", column);
		map.put("searchText", searchText);
		cnt=sqlSession.selectOne("member.searchSelectCount", map);
		
	}
	int curPage=Integer.parseInt(pageNum); //현재 페이지
	PageTest pp2=new PageTest(cnt,curPage); //페이지 처리 PageTest.java에서 생성자 호출 객체 생성
	int startPos=pp2.getStartRow()-1; //

	map.put("start",new Integer(startPos));
	map.put("count",new Integer(pp2.getPageSize())); //10개씩

	//이제 map을 넘겨줘야함
	List<MemberDto> list;
	if(searchText == "" || searchText == null) {
		list=sqlSession.selectList("member.adminSelecteList",map);		
	}else {
		
		list=sqlSession.selectList("member.searchUserList",map);
	}

	//에러처리 에러처리 방지
	if(pp2.getEndPage()>pp2.getPageCnt()) {
		pp2.setEndPage(pp2.getPageCnt());
	}
	
	model.addAttribute("pageNum",pageNum);
	model.addAttribute("searchText",searchText);
	model.addAttribute("column",column);
	
	
	model.addAttribute("pp2",pp2);
	model.addAttribute("cnt",cnt); //총 글 갯수
	model.addAttribute("list",list); //jsp에서 사용할 데이터
		
		return ".main.member.admin/list";
	}//adminList - end
	
	//Admin UserInfo
	@RequestMapping(value = "/adminUserInfo.do")
	public String adminUserInfo( String mem_id, Model model) {
		MemberDto mdto = sqlSession.selectOne("member.selectOne", mem_id);
		model.addAttribute("mdto",mdto);
		return ".main.member.admin/userPageForm";
	}//adminUserInfo - end
	
	//Admin UserDelete
	@RequestMapping(value = "/adminDeletePro.do")
	public String adminDeletePro(String mem_id, int level , Model model) {
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("id", mem_id);
			
			MemberDto mdto = sqlSession.selectOne("member.selectLogin", map);
			String msg;
			if(level<0) {
				msg = "권한이 없습니다";
			}else {
				sqlSession.delete("member.memberDelete", mem_id);
				msg = "삭제 성공";
			}
			model.addAttribute("msg","삭제 성공");

		return "redirect:/member/adminList.do";
	}//adminDeletePro - end
	
	//user Level Change
	@RequestMapping(value = "/adminLevelPro.do")
	public String adminLevelPro(String mem_id, int level , Model model) {
			HashMap<String, String> map = new HashMap<String, String>();
			if(level > 0) {
				level = 0;
			}else {
				level = 1;
			}
			
			map.put("level", level+"");
			map.put("id", mem_id);
			
			sqlSession.update("member.memberLevelUp", map);

		return "redirect:/member/adminList.do";
	}//adminLevelPro - end
	
}//class-end

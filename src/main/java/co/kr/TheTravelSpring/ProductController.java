package co.kr.TheTravelSpring;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import model.product.ProductDto;
import util.PageTest;

@Controller
@RequestMapping("/product")
public class ProductController {

	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/list.do")
	public String list(Model model,@RequestParam(value="pageNum",required=false)String pageNum,
			HttpServletRequest request) {			
		if(pageNum==null) {
			pageNum="1";
		}
		int cnt=sqlSession.selectOne("product.selectCount");//총 글갯수 얻기 
		int curPage=Integer.parseInt(pageNum);//현재 페이지
		
		PageTest pp2=new PageTest(cnt,curPage);//객체생성, 생성자 호출,페이지 처리 
		
		Map<String,Object> map=new HashMap<String,Object>();
		
		int startPos=pp2.getStartRow()-1;//***
		map.put("start", new Integer(startPos));
		map.put("count", new Integer(pp2.getPageSize()));//10개씩
		
		List<ProductDto> list=sqlSession.selectList("product.selectListBoard",map);
		//String param="수도권";
		//List<ProductDto> list = sqlSession.selectList("product.selectListLocal",param);
		  if (pp2.getEndPage()>pp2.getPageCnt()){			   
			pp2.setEndPage(pp2.getPageCnt());  
		  }	
		int number =cnt-(curPage-1)*pp2.getPageSize();//글번호 역순으로 하기

		model.addAttribute("number",number);//글번호
		model.addAttribute("pageNum",pageNum);//페이지번호				
		
		model.addAttribute("pp2",pp2);
		model.addAttribute("cnt",cnt);//총글갯수
		model.addAttribute("list",list);//jsp에서 사용할 데이터 		
		
		return ".main.product.content";
	}
	
	@RequestMapping(value="/local.do", method=RequestMethod.POST)
	
	public String local(String param, Model model) {
		
	
		List<ProductDto> list = sqlSession.selectList("product.selectListLocal",param);
				
		model.addAttribute("list",list);//jsp에서 사용할 데이터 		
		
		return "/product/local";
	}
	
//	@RequestMapping(value="/order.do", method=RequestMethod.POST)
//	public String order() {
//		return ".main.order.order";
//	}

	
	//상품예약
	@RequestMapping(value="/upload.do", method=RequestMethod.POST)
	public String reserve(@ModelAttribute("productDto") ProductDto productDto, MultipartHttpServletRequest mtfRequest) {
		
		 String src = mtfRequest.getParameter("src");
	        MultipartFile mf = mtfRequest.getFile("file");

	        String path = "C:\\_sts\\sts_work\\TheTravelSpring\\src\\main\\webapp\\resources\\imgs\\product\\";

	        String originFileName = mf.getOriginalFilename(); // 원본 파일 명
	        long fileSize = mf.getSize(); // 파일 사이즈
	        String subname = System.currentTimeMillis() + originFileName;
	        String safeFile = path + subname;
	        productDto.setFilename(subname);
	        try {
	            mf.transferTo(new File(safeFile));
	        } catch (IllegalStateException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        } catch (IOException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }
		
		sqlSession.insert("product.insert",productDto);
		
		return     "redirect:/product/list.do";
	}
	@RequestMapping(value="/register.do", method=RequestMethod.GET)
	public String register() {
		return ".main.product.register";
	}




	
	
}

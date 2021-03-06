<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ include file="../module/jsp-header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"
   integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
   crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css"   href="../resources/css/product/choice.css">
   
   <style>
   #all:hover, li:hover {
cursor:pointer;
background-color: rgb(255, 160, 51);
}
.dp{
padding-top:50px;
/* background-color: rgb(255, 160, 51); */
/* border : 1px solid black; */
margin-bottom:2%;
}
   </style>

<script>
        function numberWithCommas(x) {
            return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }
        $(function () {
           
           
           $("#register").on("click",function(){
              location.href="register.do";
           })
           
           $("#confirm").on("click", function(){           
              
              var name = $(".name").text();
              var price = $(".total").val();
              var person = $(".person").val();
              
           
              $("#name").val(name);
              $("#price").val(price);
              $("#person").val(person);
              $("#start").val(start);
              $("#end").val(end);
              alert(name);
           })

           $("#all").on("click",function(){
              location.href="list.do"
           })
//         $("#review").on("click",function(){
//               location.href="???"
//            })
           
           $("li").on("click",function(){
              var param = $(this).text();

          $.ajax({            
            url:"${ctxpath}/product/local.do",
           type:"POST",
           data: {param : param},
            dataType:'html',
           success: function(data){
              
                $('#content').html("");
                $('#content').html(data);
              
           }, error:function(){
              alert("????????? ????????? ????????????");
           }
            })
         
           });


        })
    </script>

</head>
<body>
<br>
<c:if test="${sessionScope.userLevel > 0}">
  <div style="text-align: right;">
	<input id=register type=button class=ho value="????????????">
  </div>
</c:if>

   <input type=hidden name="id" id=id>
   <input type=hidden name="name" id="name">
   <input type=hidden name="price" id=price>
   <input type=hidden name="person" id=person>
   <input type=hidden name="start" id=start>
   <input type=hidden name="end" id=end>
   <div id=wraps class=float>
      <div id=sidemenu class=float>

         <input type=hidden id=local name=local> 
         <span id=all class=ho>????????????</span> <br>
         
         
         <br>
         <br> ??????
         <ul>
            <li >?????????</li>
            <br>
            <li>?????????</li>
            <br>
            <li>?????????</li>
            <br>
            <li>?????????</li>
            <br>
            <li>?????????</li>
            <br>
            <li>?????????</li>
            <br>
            <li>??????/??????</li>
            <br>
         </ul>
         <br> ??????
         <ul>
            <li>?????????</li>
            <br>
            <li>??????</li>
            <br>
            <li>????????????</li>
            <br>
            <li>??????</li>
         </ul>
        

      </div>

      <div id=content class=float>
         
         <c:forEach var="dto" items="${list}">
      
            <div id=body_top>
            <div id="div${dto.id}" class=dp></div>
               <div id=body_top_left>
               <img src="../resources/imgs/product/${dto.filename } ">
<%--                   ${dto.filename } --%>
               </div>
               <div id=body_top_right>
                  <div class="name">${dto.name }</div>
                  <hr>
                  <br>
                  <div id=icon>
                     <div>
                        <img src="../resources/imgs/product/calendar.png"> <span>
                           ?????? ?????? ??????</span>
                     </div>
                     <div>
                        <img src="../resources/imgs/product/shopping.png"> <span>????????????</span>
                     </div>
                  </div>
                  <div class=clear></div>
                  <br>
                  <hr>
                  <br> 
<!--                   <input type=button id=confirm value=????????????>  -->

                  <form method="get" action="${ctxpath}/order/writeForm.do">
                  <input name=pro_no type=hidden value=${dto.id }>
                  <input type=submit value=????????????> 
                  </form><br>
                  <form method="get" action="${ctxpath}/review/list.do">
                    <input name=pro_no type=hidden value=${dto.id }>
                  <input type=submit id=review value=????????????>
                  </form>
                  <p>
                     ??????/?????? 1??? <br>
                  </p>
                  <div id=price>
                     <strong>${dto.price}</strong>???
                  </div>
               </div>
               <div class=clear></div>

               <div id=body_bottom>
                  <hr>
                  <div id=body_bottom_left>
                     <table id=table1>
                        <th colspan="2">
                           <h3>?????? ????????????</h3>
                        </th>
                        <tr>
                           <td>
                              <h5>??????</h5>
                           </td>
                           <td>${dto.start}~${dto.end}</td>
                        </tr>
                        <tr>
                           <td>
                              <h5>????????????</h5>
                           </td>
                           <td>${dto.city}</td>
                        </tr>

                     </table>
                     <br>
                  </div>
               </div>
               <div class=clear></div>
               </div>
            
            
            <div id=line></div>
          
         </c:forEach>
         
      </div>
   </div>

</body>
</html>
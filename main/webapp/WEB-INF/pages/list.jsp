<%--
  Created by IntelliJ IDEA.
  User: Lsr
  Date: 10/20/14
  Time: 4:30 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="htmlframe/headFrame.jsp" />
<link rel="stylesheet" type="text/css" href="/css/main.css" />
<body class="skin-blue">
<!-- header logo: style can be found in header.less -->
<c:import url="htmlframe/headerFrame.jsp"/>
<div class="wrapper row-offcanvas row-offcanvas-left">
    <!-- Left side column. contains the logo and sidebar -->
    <c:import url="htmlframe/leftFrame.jsp" />

    <!-- Right side column. Contains the navbar and content of the page -->
    <aside class="right-side">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                アイテム一覧
            </h1>
            <ol class="breadcrumb">
                <li><i class="fa fa-dashboard"></i> アイテム一覧</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">

            <div class="row">
                <div class="col-md-12 col-xs-12">
                    <div class="box box-solid">
                        <div class="box-body no-padding">
                            <div class="form-group" style="margin-bottom:0px">
                                <div class="row">
                                    <div class="col-md-6 col-xs-6">
                                        <div class="row">
                                            <div class=" col-md-8 col-xs-12 btn-group">
                                                <button class="btn btn-flat item-tab item-tab-active">全体</button>
                                                <button class="btn btn-default btn-flat item-tab">バルブ</button>
                                                <button class="btn btn-default btn-flat item-tab">機器</button>
                                                <button class="btn btn-default btn-flat item-tab">部品</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-xs-6">
                                        <form action="/search" id="searchForm" method="post">
                                            <div class="input-group search-div">

                                                <input type="text" class="form-control" id="keyword-input" name="keyword" placeholder="keywords">
                                                <span class="input-group-btn">
                                                    <input class="btn btn-default btn-flat" id="keyword-btn" type="button" value="検索"/>
                                                </span>

                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- data tables -->
                    <!--rgba(60, 141, 188, 0.94)-->
                    <div class="box box-primary result-box">
                        <div class="box-header">
                            <h3 class="box-title">バルブ一覧</h3>
                            <div class="box-tools">
                                <div class="btn-group pull-right"  id="valuePage">
                                    <button type="button" class="btn btn-default" >1</button>
                                    <button type="button" class="btn btn-default" >2</button>
                                    <button type="button" class="btn btn-default" >3</button>
                                    <button type="button" class="btn btn-default" >4</button>
                                    <button type="button" class="btn btn-default" >5</button>
                                    <button type="button" class="btn btn-default" >6</button>
                                    <button type="button" class="btn btn-default" >7</button>
                                    <button type="button" class="btn btn-default" >8</button>
                                    <button type="button" class="btn btn-default" >9</button>
                                    <button type="button" class="btn btn-default" >10</button>
                                </div>
                            </div>
                        </div>

                        <div class="box-body no-padding">

                                <div class="list-group valve-list result-list">

                                    <c:forEach items="${valveResults}" var="valveResult">
                                        <a href="/item/${valveResult.id}" class="list-group-item">${valveResult.body}</a>
                                    </c:forEach>
                                </div>

                        </div>
                    </div>

                    <div class="box box-kiki result-box">
                        <div class="box-header">
                            <h3 class="box-title">機器一覧</h3>
                            <div class="box-tools">
                                <div class="btn-group pull-right"  id="kikiPage">
                                    <button type="button" class="btn btn-default" >1</button>
                                    <button type="button" class="btn btn-default" >2</button>
                                    <button type="button" class="btn btn-default" >3</button>
                                    <button type="button" class="btn btn-default" >4</button>
                                    <button type="button" class="btn btn-default" >5</button>
                                    <button type="button" class="btn btn-default" >6</button>
                                    <button type="button" class="btn btn-default" >7</button>
                                    <button type="button" class="btn btn-default" >8</button>
                                    <button type="button" class="btn btn-default" >9</button>
                                    <button type="button" class="btn btn-default" >10</button>
                                </div>
                            </div>
                        </div>

                        <div class="box-body no-padding">

                            <div class="list-group kiki-list result-list">

                                <c:forEach items="${kikiResults}" var="kikiResult">
                                    <a href="/search/${kikiResult.id}" class="list-group-item">${kikiResult.body}</a>
                                </c:forEach>
                            </div>

                        </div>
                    </div>

                    <div class="box box-warning result-box">
                        <div class="box-header">
                            <h3 class="box-title">部品一覧</h3>
                            <div class="box-tools">
                                <div class="btn-group pull-right"  id="buhinPage">
                                    <button type="button" class="btn btn-default" >1</button>
                                    <button type="button" class="btn btn-default" >2</button>
                                    <button type="button" class="btn btn-default" >3</button>
                                    <button type="button" class="btn btn-default" >4</button>
                                    <button type="button" class="btn btn-default" >5</button>
                                    <button type="button" class="btn btn-default" >6</button>
                                    <button type="button" class="btn btn-default" >7</button>
                                    <button type="button" class="btn btn-default" >8</button>
                                    <button type="button" class="btn btn-default" >9</button>
                                    <button type="button" class="btn btn-default" >10</button>
                                </div>
                            </div>
                        </div>

                        <div class="box-body no-padding">
                            <div class="list-group buhin-list result-list">
                                <c:forEach items="${buhinResults}" var="buhinResult">
                                    <a href="/search/${buhinResult.id}" class="list-group-item">${buhinResult.body}</a>
                                </c:forEach>
                            </div>
                        </div>
                    </div>

                </div>
            </div>


        </section><!-- /.content -->
    </aside><!-- /.right-side -->
</div><!-- ./wrapper -->

<!-- add new calendar event modal -->

<script type="text/javascript">
    $(document).ready(function(){
        $("#keyword-input").focus(function(){
            $(".search-div").animate({"margin-left":"0"},300,function(){
                $("#keyword-btn").toggleClass("bg-red");
            });
        });
        $("#keyword-input").blur(function(){
            $(".search-div").animate({"margin-left":"50%"},300,function(){
                $("#keyword-btn").toggleClass("bg-red");
            });
        });

        $(".result-table tr").mouseover(function(obj){
            var tr = $(obj.currentTarget)[0];
            $(tr).find(".operation-button").css("opacity","1");
        });
        $(".result-table tr").mouseout(function(obj){
            var tr = $(obj.currentTarget)[0];
            $(tr).find(".operation-button").css("opacity","0");
        });
        //set the background-color
        var valveTrs = $(".valve-list a");
        var colorOffset = 1/valveTrs.length;
        for(var i = 0;i<valveTrs.length;i++){
            $(valveTrs[i]).css({"background-color":"rgba(100, 161, 200, "+colorOffset*(i+1)+")"});
        }
        var kikiTrs = $(".kiki-list a");
        colorOffset = 1/kikiTrs.length;
        for(var i = 0;i<kikiTrs.length;i++){
            $(kikiTrs[i]).css({"background-color":"rgba(62, 212, 214, "+colorOffset*(i+1)+")"});
        }
        var buhinTrs = $(".buhin-list a");
        colorOffset = 1/buhinTrs.length;
        for(var i = 0;i<buhinTrs.length;i++){
            $(buhinTrs[i]).css({"background-color":"rgba(245, 157, 0, "+colorOffset*(i+1)+")"});
        }

        //--------Value Paging Start
        var valueButton=$("#valuePage button");
        var kikiButton=$("#kikiPage button");
        var buhinButton=$("#buhinPage button");

        var datanum=10;
        paging(valveTrs.length,valueButton,valveTrs,10);
        paging(kikiTrs.length,kikiButton,kikiTrs,10);
        paging(buhinTrs.length,buhinButton,buhinTrs,10);

        function paging(num,ButtonType,DataType,datanum){
            var pagenumTotal=pageCount(num,datanum);
            //button hide
            for(var i = pagenumTotal;i<10;i++){
                ButtonType.eq(i).hide();
            }
            //show the first 10
            DataType.hide();
            for(var i = 0;i<datanum;i++){
                DataType.eq(i).show();
            }
            //  pagnation
            ButtonType.click(function(){
                var pageNumClick=ButtonType.index(this);
                ButtonType.removeClass('active');
                $(ButtonType[pageNumClick]).addClass("active");
                DataType.hide();
                for(var i = pageNumClick*datanum;i<(pageNumClick+1)*datanum;i++){
                    DataType.eq(i).show();
                }
            });
        }

        function pageCount(num,datanum){
            var pagenumTotal=parseInt(num/datanum);
            var mod=num%datanum;
            if (mod!=0){
                pagenumTotal=pagenumTotal+1;
            }
            return pagenumTotal;
        }
        //--------Value Paging End

        $(".item-tab").click(function(){
            $(".item-tab").removeClass("item-tab-active");
            $(".item-tab").addClass("btn-default");
            $($(this)[0]).removeClass("btn-default");
            $($(this)[0]).addClass("item-tab-active");
            $(".result-box").hide();
            var text = $($(this)[0]).html();
            if(text == "バルブ"){
                $(".box-primary").show(200);
                paging(valveTrs.length,valueButton,valveTrs,16);
            } else if(text == "機器"){
                $(".box-kiki").show(200);
                paging(kikiTrs.length,kikiButton,kikiTrs,16);
            } else if(text == "部品"){
                $(".box-warning").show(200);
                paging(buhinTrs.length,buhinButton,buhinTrs,16);
            } else {
                $(".result-box").show(200);
                paging(valveTrs.length,valueButton,valveTrs,10);
                paging(kikiTrs.length,kikiButton,kikiTrs,10);
                paging(buhinTrs.length,buhinButton,buhinTrs,10);
            }
        });

        $("#keyword-btn").click(function(){
            var keywords = new String($("#keyword-input").val());
            keywords = keywords.toLowerCase();

            if(keywords.length<1){
                return false;
            } else {
                var ills = new Array();
                ills = ['+', '&&', '||', '!', '(', ')' ,'{' ,'}', '[', ']', '^', '"', '~', '*', '?', ':'];
                for(var i = 0;i<ills.length;i++){
                    if(keywords.indexOf(ills[i]) > -1){
                        alert("キーワードは正しくありません");
                        return false;
                    }
                }

            }
            $("#keyword-input").val(keywords);
            $("#searchForm").submit();
        });
    });
</script>

<c:import url="htmlframe/footerFrame.jsp" />

</body>

</html>

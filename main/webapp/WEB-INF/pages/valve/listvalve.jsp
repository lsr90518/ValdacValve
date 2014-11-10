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
<c:import url="../htmlframe/headFrame.jsp" />
<link rel="stylesheet" type="text/css" href="/css/edit.css" />

<body class="skin-blue">
<!-- header logo: style can be found in header.less -->
<c:import url="../htmlframe/headerFrame.jsp"/>
<div class="wrapper row-offcanvas row-offcanvas-left">
<!-- Left side column. contains the logo and sidebar -->
<c:import url="../htmlframe/leftFrame.jsp" />

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

<%--<div class="row">--%>
<%--<div class="col-md-12">--%>

<%--</div>--%>
<%--</div>--%>

<%--<div class="row">--%>
<%--<!-- collection -->--%>
<%--<div class="col-xs-12">--%>
<%--<form action="/search" method="post">--%>
<%--<input type="text" name="keyword" class="form-control" />--%>
<%--<input type="submit" class="btn btn-danger btn-circle" value="検索" />--%>
<%--</form>--%>
<%--</div>--%>

<%--</div>--%>

<%--<div class="form-group">--%>
<%--<c:forEach items="${results}" var="result">--%>
<%--<div class="row">--%>
<%--<div class="col-md-2">${result.id}</div>--%>
<%--<div class="col-md-10">${result.body}</div>--%>
<%--</div>--%>
<%--</c:forEach>--%>
<%--</div>--%>
    <div class="row">
        <div class="col-md-12 col-xs-12">
            <div class="box box-solid">
            <div class="box-body no-padding">
                <div class="form-group" style="margin-bottom:0px">
                    <div class="row">
                        <div class="col-md-6 col-xs-6">
                            <div class="row">
                                <div class=" col-md-8 col-xs-12 btn-group">
                                    <a href="/list" class="btn btn-default btn-flat">全体</a>
                                    <a href="/list/valve" class="btn btn-default btn-flat bg-light-blue">バルブ</a>
                                    <a href="/list/kiki" class="btn btn-default btn-flat">機器</a>
                                    <a href="/list/buhin" class="btn btn-default btn-flat">部品</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-xs-6">
                            <div class="input-group search-div">
                                <input type="text" class="form-control" id="keyword-input" name="keyword" placeholder="keywords">
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default btn-flat" id="keyword-btn" type="button">検索</button>
                                                    </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

            <!-- data tables -->
            <!--rgba(60, 141, 188, 0.94)-->
            <div class="box box-primary">
            <div class="box-header">
                <h3 class="box-title">バルブ一覧</h3>
            </div>
            <div class="box-body no-padding">
                <table class="table valve-table result-table">
                    <tr>
                        <th>弁番号</th>
                        <th>弁名称</th>
                        <th>型式</th>
                        <th>操作</th>
                        <th>クラス</th>
                        <th>呼び径</th>
                        <th>規格</th>
                        <th>材質</th>
                        <th></th>
                    </tr>
                    <c:forEach items="${valveList}" var="tmpValve">
                        <tr>
                            <td>${tmpValve.vNo}</td>
                            <td>${tmpValve.benMeisyo}</td>
                            <td>${tmpValve.keisiki}</td>
                            <td>${tmpValve.sousa}</td>
                            <td>${tmpValve.classType}</td>
                            <td>${tmpValve.yobikei}</td>
                            <td>${tmpValve.szKikaku}</td>
                            <td>${tmpValve.zaisitu}</td>
                            <td>
                                <a class="btn btn-primary btn-short operation-button" href="/valve/${tmpValve.kikiSysId}"><i class="fa fa-pencil"></i></a>
                                <a class="btn btn-danger btn-short operation-button" href="/valve/delete/${tmpValve.kikiSysId}"><i class="fa fa-trash-o"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
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
            $(".search-div").animate({"margin-left":"0"},500,function(){
                $("#keyword-btn").toggleClass("bg-red");
            });
        });
        $("#keyword-input").blur(function(){
            $(".search-div").animate({"margin-left":"50%"},500,function(){
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

        var valveTrs = $(".valve-table tr");
        var colorOffset = 1/valveTrs.length;
        for(var i = 0;i<valveTrs.length;i++){
            $(valveTrs[i]).css({"background-color":"rgba(60, 141, 188, "+colorOffset*i+")"});
        }

    });
</script>

<c:import url="../htmlframe/footerFrame.jsp" />

</body>

</html>

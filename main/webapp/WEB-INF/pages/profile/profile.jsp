<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:import url="../htmlframe/headFrame.jsp" />
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
            プロフィール情報
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Index</a></li>
            <li class="active">プロフィール修正</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">

        <c:if test="${message != null}">
            <div class="row">
                <div class="col-md-12">
                    <div class="alert alert-success alert-dismissable">${message}</div>
                </div>
            </div>
        </c:if>


        <form role="form" class="box-body-form" name="UserForm" id="UserForm" method="post" action="/profile/updateUserProfile">
            <!-- collection -->

            <div class="nav-tabs-custom">
                <!-- Tabs within a box -->
                <ul class="nav nav-tabs pull-right">
                    <li class="active"><a href="#revenue-chart">個人情報</a></li>
                    <li><a href="/profile/getUserProfileImage">写真</a></li>
                    <li class="pull-left header"><i class="fa fa-edit"></i></li>
                </ul>
                <div class="tab-content">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-2">
                                <input type="button" class="btn btn-primary"  value="ユーザ名"/>
                            </div>
                            <div class="col-md-10">
                                <input type="text" id="username" name="username" class="form-control" value=${user.username}>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-2">
                                <input type="button" class="btn btn-primary"  value="パスワード"/>
                            </div>
                            <div class="col-md-10">
                                <input type="password" id="password" name="password" class="form-control" value=${user.password}>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-2">
                                <input type="button" class="btn btn-primary"  value="部署"/>
                            </div>
                            <div class="col-md-10">
                                <input type="text" id="department" name="department" class="form-control" value=${user.department}>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <a class="btn btn-default" href="/profile/getUserProfile" >リセット</a>
                        <button class="btn btn-success pull-right">
                            <i class="fa fa-save"></i> 更新
                        </button>
                    </div>
                </div>
            </div>
        </form>

    </section><!-- /.content -->
</aside><!-- /.right-side -->
</div><!-- ./wrapper -->


<script type="text/javascript">
    $(document).ready(function(){

        $(".box-panel").click(function(){
            $(this).next().toggle();
        });
    });

    function getAllValve(){
        $.get("/valve/getAllValveJson",function(data){
                alert(data[0]);
        });
    }

    function getMasterByType(obj){
        var id=obj.id;
        var typeName="";
//        alert(id);
        $.getJSON("/master/getMasterByTypeJson?id="+id,function(data){

            for(var nIndex=0;nIndex<data.length;nIndex++){
//                alert(data[nIndex].Name);
                typeName=typeName+data[nIndex].name+'¥n';
            };

            alert(typeName);
        });
    }
</script>

<c:import url="../htmlframe/footerFrame.jsp" />


</body>
</html>
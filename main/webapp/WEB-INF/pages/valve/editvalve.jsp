<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="../htmlframe/headFrame.jsp" />

<link href="/css/editvalve.css" rel="stylesheet" type="text/css" />
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
        アイテム編集
        <small>弁情報編集</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="/"><i class="fa fa-dashboard"></i> Index</a></li>
        <li class="active">弁情報編集</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <!-- message -->
    <c:if test="${message != null}">
        <div class="row">
            <div class="col-md-12">
                <div class="alert alert-success alert-dismissable">${message}</div>
            </div>
        </div>
    </c:if>
    <div class="row">
        <form role="form" class="box-body-form" method="post" action="/valve/update">
            <!-- collection -->
            <!-- kikiSysId -->
            <input type="hidden" name="kikiSysId" id="kikiSysId" value="${valve.kikiSysId}" />
            <div class="col-lg-12">
                <div class="box box-primary">
                    <div class="box-header box-panel">
                        <h3 class="box-title">弁情報</h3>
                    </div>


                    <div class="box-body">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4">
                                    <input type="text" id="VNo" name="VNo" class="form-control" placeholder="弁番号" value="${valve.vNo}">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" id="VNoSub" name="VNoSub" class="form-control" placeholder="職番" value="${valve.vNoSub}">
                                </div>
                                <div class="col-md-6">
                                    <input type="text" id="BenMeisyo" name="BenMeisyo" class="form-control" placeholder="弁名称" value="${valve.benMeisyo}">
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-2">
                                    <input type="button" class="btn btn-primary"  value="ICS番号"/>
                                </div>
                                <div class="col-md-10">
                                    <input type="text" id="ics" name="ics" class="form-control" value="${valve.ics}">
                                </div>
                            </div>
                        </div>
                    </div><!-- /.box-body -->

                </div>

                <div class="box box-danger">
                    <div class="box-header box-panel">
                        <h3 class="box-title">弁仕様</h3>
                    </div>

                    <div class="box-body">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-3">
                                    <input type="text" id="AturyokuMax" name="AturyokuMax" class="form-control" placeholder="圧力" value="${valve.aturyokuMax}">
                                </div>
                                <div class="col-md-3">
                                    <input type="text" id="Tani" name="Tani" class="form-control" placeholder="単位" value="${valve.tani}">
                                </div>
                                <div class="col-md-3">
                                    <input type="text" id="OndoMax" name="OndoMax" class="form-control" placeholder="温度℃" value="${valve.ondoMax}" >
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-1">
                                    <input type="button" class="btn btn-danger" onclick="getMasterByType(this)" id="14" value="流体" />
                                </div>
                                <div class="col-md-2">
                                    <input type="text" id="RyutaiRyaku" name="RyutaiRyaku" class="form-control" placeholder="略称" value="${valve.ryutaiRyaku}">
                                </div>
                                <div class="col-md-3">
                                    <input type="text" id="Ryutai" name="Ryutai" class="form-control" value="${valve.ryutai}">
                                </div>
                                <div class="col-md-1">
                                    <input type="button" class="btn btn-danger" onclick="getMasterByType(this)" id="7" value="形式" />

                                </div>
                                <div class="col-md-2">
                                    <input type="text" id="KeisikiRyaku" name="KeisikiRyaku" class="form-control" value="${valve.keisikiRyaku}">
                                </div>
                                <div class="col-md-3">
                                    <input type="text" id="Keisiki" name="Keisiki" class="form-control" placeholder="" value="${valve.keisiki}">
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-1">
                                    <input type="button" class="btn btn-danger" onclick="getMasterByType(this)" id="8" value="駆動方式" />
                                </div>
                                <div class="col-md-2">
                                    <input type="text" id="SousaRyaku" name="SousaRyaku" class="form-control" placeholder="略称" value="${valve.sousaRyaku}">
                                </div>
                                <div class="col-md-3">
                                    <input type="text" id="Sousa" name="Sousa" class="form-control" value="${valve.sousa}">
                                </div>
                                <div class="col-md-1">
                                    <input type="button" class="btn btn-danger" onclick="getMasterByType(this)" id="9" value="クラス" />

                                </div>
                                <div class="col-md-2">
                                    <input type="text" id="ClassRyaku" name="ClassRyaku" class="form-control" placeholder="" value="${valve.classRyaku}">
                                </div>
                                <div class="col-md-3">
                                    <input type="text" id="ClassType" name="ClassType" class="form-control" placeholder="" value="${valve.classType}">
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-1">
                                    <input type="button" class="btn btn-danger" onclick="getMasterByType(this)" id="10" value="呼び径" />
                                </div>
                                <div class="col-md-2">
                                    <input type="text" id="YobikeiRyaku" name="YobikeiRyaku" class="form-control" placeholder="略称" value="${valve.yobikeiRyaku}">
                                </div>
                                <div class="col-md-3">
                                    <input type="text" id="Yobikei" name="Yobikei" class="form-control" value="${valve.yobikei}">
                                </div>
                                <div class="col-md-1">
                                    <input type="button" class="btn btn-danger" onclick="getMasterByType(this)" id="11" value="接続入口" />

                                </div>
                                <div class="col-md-2">
                                    <input type="text" id="SzHouRyaku" name="SzHouRyaku" class="form-control" placeholder="" value="${valve.szHouRyaku}">
                                </div>
                                <div class="col-md-3">
                                    <input type="text" id="SzHou" name="SzHou" class="form-control" placeholder=""value="${valve.szHou}">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-1">
                                    <input type="button" class="btn btn-danger" onclick="getMasterByType(this)" id="12" value="接続規格" />
                                </div>
                                <div class="col-md-5">
                                    <input type="text" id="SzKikaku" name="SzKikaku" class="form-control" value="${valve.szKikaku}">
                                </div>
                                <div class="col-md-1">
                                    <input type="button" class="btn btn-danger" onclick="getMasterByType(this)" id="13" value="本体材質" />

                                </div>
                                <div class="col-md-2">
                                    <input type="text" id="ZaisituRyaku" name="ZaisituRyaku" class="form-control" placeholder="略称" value="${valve.zaisituRyaku}">
                                </div>
                                <div class="col-md-3">
                                    <input type="text" id="Zaisitu" name="Zaisitu" class="form-control" placeholder="" value="${valve.zaisitu}">
                                </div>
                            </div>
                        </div>
                    </div><!-- /.box-body -->


                </div>

                <div class="box box-warning">
                    <div class="box-header box-panel">
                        <h3 class="box-title">付帯情報</h3>
                    </div>

                    <div class="box-body">
                        <div class="form-group">
                            <textarea class="form-control" id="Futai" name="Futai" rows="3" value="${valve.futai}"></textarea>
                        </div>
                    </div>
                </div>

                <div class="box box-solid">

                    <div class="box-body clearfix">
                        <div class="form-group">
                            <a class="btn btn-info" href="/kiki">
                                <i class="fa fa-list"></i> 機器情報編集
                            </a>

                            <button class="btn btn-success pull-right">
                                <i class="fa fa-save"></i> 更新
                            </button>
                        </div>
                    </div>
                </div>

            </div>
        </form>
    </div>

</section><!-- /.content -->
</aside><!-- /.right-side -->
</div><!-- ./wrapper -->


<script type="text/javascript">
    $(document).ready(function(){

        $("#left-menu-edit").addClass("active");
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
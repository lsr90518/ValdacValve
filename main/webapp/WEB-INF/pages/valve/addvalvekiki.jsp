<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="../htmlframe/headFrame.jsp" />

<link type="text/css" rel="stylesheet" href="/css/main.css"/>

<body class="skin-blue">
<!-- header logo: style can be found in header.less -->

<c:import url="../htmlframe/headerFrame.jsp" />

<div class="wrapper row-offcanvas row-offcanvas-left">
<!-- Left side column. contains the logo and sidebar -->
<c:import url="../htmlframe/leftFrame.jsp" />

<!-- Right side column. Contains the navbar and content of the page -->
<aside class="right-side">
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        新規登録
        <small>弁情報登録</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="/"><i class="fa fa-dashboard"></i> Index</a></li>
        <li class="active"><a href="/item/${valve.kikiSysId}">${valve.benMeisyo}</a></li>
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

<div class="row">
    <form role="form" id="valveForm" class="box-body-form" method="post" action="/item/edit">
        <!-- collection -->
        <input type="hidden" name="kikiSysId" id="kikiSysId" value="${valve.kikiSysId}"/>
        <div class="col-lg-12">
            <div class="box box-solid box-primary">
                <div class="box-header box-panel">
                    <h3 class="box-title">${valve.benMeisyo}の弁情報</h3>
                </div>


                <div class="box-body" style="display: none">
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

            <div class="box box-solid box-danger">
                <div class="box-header box-panel">
                    <h3 class="box-title">${valve.benMeisyo}の弁仕様</h3>
                </div>

                <div class="box-body" style="display: none">
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
                                <input type="button" class="btn btn-danger master-ryutai" onclick="getMasterByType(this)"  data-toggle="modal" data-target="#masterModal" id="14" value="流体" />
                            </div>
                            <div class="col-md-2">
                                <input type="text" id="RyutaiRyaku" name="RyutaiRyaku" class="form-control ryutai" placeholder="略称" value="${valve.ryutaiRyaku}">
                            </div>
                            <div class="col-md-3">
                                <input type="text" id="Ryutai" name="Ryutai" class="form-control ryutai" value="${valve.ryutai}">
                            </div>
                            <div class="col-md-1">
                                <input type="button" class="btn btn-danger master-keisiki" onclick="getMasterByType(this)"  data-toggle="modal" data-target="#masterModal" id="7" value="形式" />

                            </div>
                            <div class="col-md-2">
                                <input type="text" id="KeisikiRyaku" name="KeisikiRyaku" class="form-control keisiki" value="${valve.keisikiRyaku}">
                            </div>
                            <div class="col-md-3">
                                <input type="text" id="Keisiki" name="Keisiki" class="form-control keisiki" placeholder="" value="${valve.keisiki}">
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-1">
                                <input type="button" class="btn btn-danger master-sousa" onclick="getMasterByType(this)"  data-toggle="modal" data-target="#masterModal" id="8" value="駆動方式" />
                            </div>
                            <div class="col-md-2">
                                <input type="text" id="SousaRyaku" name="SousaRyaku" class="form-control sousa" placeholder="略称" value="${valve.sousaRyaku}">
                            </div>
                            <div class="col-md-3">
                                <input type="text" id="Sousa" name="Sousa" class="form-control sousa" value="${valve.sousa}">
                            </div>
                            <div class="col-md-1">
                                <input type="button" class="btn btn-danger master-classtype" onclick="getMasterByType(this)"  data-toggle="modal" data-target="#masterModal" id="9" value="クラス" />

                            </div>
                            <div class="col-md-2">
                                <input type="text" id="ClassRyaku" name="ClassRyaku" class="form-control classtype" placeholder="" value="${valve.classRyaku}">
                            </div>
                            <div class="col-md-3">
                                <input type="text" id="ClassType" name="ClassType" class="form-control classtype" placeholder="" value="${valve.classType}">
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-1">
                                <input type="button" class="btn btn-danger master-yobikei" onclick="getMasterByType(this)"  data-toggle="modal" data-target="#masterModal" id="10" value="呼び径" />
                            </div>
                            <div class="col-md-2">
                                <input type="text" id="YobikeiRyaku" name="YobikeiRyaku" class="form-control yobikei" placeholder="略称" value="${valve.yobikeiRyaku}">
                            </div>
                            <div class="col-md-3">
                                <input type="text" id="Yobikei" name="Yobikei" class="form-control yobikei" value="${valve.yobikei}">
                            </div>
                            <div class="col-md-1">
                                <input type="button" class="btn btn-danger master-szhou" onclick="getMasterByType(this)"  data-toggle="modal" data-target="#masterModal" id="11" value="接続入口" />

                            </div>
                            <div class="col-md-2">
                                <input type="text" id="SzHouRyaku" name="SzHouRyaku" class="form-control szhou" placeholder="" value="${valve.szHouRyaku}">
                            </div>
                            <div class="col-md-3">
                                <input type="text" id="SzHou" name="SzHou" class="form-control szhou" placeholder=""value="${valve.szHou}">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-1">
                                <input type="button" class="btn btn-danger master-szkikaku" onclick="getMasterByType(this)"  data-toggle="modal" data-target="#masterModal" id="12" value="接続規格" />
                            </div>
                            <div class="col-md-5">
                                <input type="text" id="SzKikaku" name="SzKikaku" class="form-control szkikaku" value="${valve.szKikaku}">
                            </div>
                            <div class="col-md-1">
                                <input type="button" class="btn btn-danger master-Zaisitu" onclick="getMasterByType(this)"  data-toggle="modal" data-target="#masterModal" id="13" value="本体材質" />

                            </div>
                            <div class="col-md-2">
                                <input type="text" id="ZaisituRyaku" name="ZaisituRyaku" class="form-control Zaisitu" placeholder="略称" value="${valve.zaisituRyaku}">
                            </div>
                            <div class="col-md-3">
                                <input type="text" id="Zaisitu" name="Zaisitu" class="form-control Zaisitu" placeholder="" value="${valve.zaisitu}">
                            </div>
                        </div>
                    </div>
                </div><!-- /.box-body -->


            </div>

            <div class="box box-solid box-warning">
                <div class="box-header box-panel">
                    <h3 class="box-title">付帯情報</h3>
                </div>

                <div class="box-body" style="display: none">
                    <div class="form-group">
                        <textarea class="form-control" id="Futai" name="Futai" rows="1" value="${valve.futai}"></textarea>
                    </div>
                </div>
            </div>

            <div class="box box-solid">
                <div class="box-body clearfix">
                    <div class="form-group">

                        <a class="btn btn-danger" href="/item/${valve.kikiSysId}/delete">
                            <i class="fa fa-refresh"></i> 削除
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

<div class="row">
    <!-- collection -->
    <div class="col-lg-12">
        <div class="box  box-kiki">
            <div class="box-header box-panel">
                <h3 class="box-title">${valve.benMeisyo}の機器一覧</h3>
            </div>
            <div class="box-body">
                <div class="row">
                    <div class="col-md-8">
                        <button class="btn btn-success btn-kiki" data-toggle="modal" data-target=".content-modal">追加</button>
                    </div>
                </div>
                <div class="box-body table-responsive no-padding">
                    <table class="table table-hover kiki-table">
                        <tbody><tr>
                            <th>弁分類</th>
                            <th>連番</th>
                            <th>主管係</th>
                            <th>機器名称</th>
                            <th>メーカ名</th>
                            <th>型式番号</th>
                            <th>シリアル</th>
                            <th>オーダー</th>
                            <th>操作</th>
                        </tr>
                        <c:forEach items="${kikiList}" var="tmpkiki">
                            <tr>
                                <td>${tmpkiki.kikiBunrui}</td>
                                <td>${tmpkiki.kikiBunruiSeq}</td>
                                <td>${tmpkiki.kikiMei}</td>
                                <td>${tmpkiki.syukan}</td>
                                <td>${tmpkiki.maker}(${tmpkiki.makerRyaku})</td>
                                <td>${tmpkiki.katasikiNo}</td>
                                <td>${tmpkiki.serialNo}</td>
                                <td>${tmpkiki.orderNo}</td>

                                <td>
                                    <div class="operation-button">
                                        <a class="btn btn-danger btn-sm operation-button-btn" href="/item/${valve.kikiSysId}/${tmpkiki.kikiId}/delete"><i class="fa fa-trash-o"></i></a>
                                        <a class="btn btn-info btn-sm operation-button-btn" href="/item/${valve.kikiSysId}/${tmpkiki.kikiId}"><i class="fa fa-arrow-right"></i></a>
                                    </div>
                                </td>
                            </tr>

                        </c:forEach>
                        </tbody></table>
                </div>
            </div>
        </div>


    </div>
</div><!-- insert -->

<!-- add content modal -->
<div id="kiki-modal" class="modal fade content-modal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
    <form action="/item/${valve.kikiSysId}/add" id="KikiForm" name="KikiForm" method="post">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="myModalLabel">機器登録</h4>
                </div>
                <div class="modal-body">

                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-2">
                                機器分類
                            </div>
                            <div class="col-md-10">
                                <select name="kikiBunrui" class="form-control">
                                    <option>弁</option>
                                    <option>駆動部</option>
                                    <option>補助部</option>
                                    <option>付属部</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-2">
                                機器番号
                            </div>
                            <div class="col-md-10">
                                <input type="text" name="kikiNo" class="form-control" />
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-2">
                                機器名称
                            </div>
                            <div class="col-md-10">
                                <input type="text" name="kikiMei" class="form-control" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-2">
                                主管係
                            </div>
                            <div class="col-md-10">
                                <input type="text" name="syukan" class="form-control" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-2">
                                <input type="button" class="btn btn-default" value="メーカー" />
                            </div>
                            <div class="col-md-3">
                                略称
                            </div>
                            <div class="col-md-7">
                                <input type="text" name="maker" class="form-control" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-2">
                                型式番号
                            </div>
                            <div class="col-md-10">
                                <input type="text" name="katasikiNo" class="form-control" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-2">
                                シリアル番号
                            </div>
                            <div class="col-md-10">
                                <input type="text" name="serialNo" class="form-control" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-2">
                                オーダー番号
                            </div>
                            <div class="col-md-10">
                                <input type="text" name="orderNo" class="form-control" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-2">
                                備考
                            </div>
                            <div class="col-md-10">
                                <input type="text" name="bikou"class="form-control" />
                            </div>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <input type="submit" class="btn btn-success" value="登録" />
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



        $("#left-menu-new").addClass("active");

        $(".box-panel").click(function(){
            $(this).next().toggle();
        });

        $(".kiki-table tr").mouseover(function(obj){
            var tr = $(obj.currentTarget)[0];
            $(tr).find(".operation-button").css("opacity","1");
        });
        $(".kiki-table tr").mouseout(function(obj){
            var tr = $(obj.currentTarget)[0];
            $(tr).find(".operation-button").css("opacity","0");
        });

    });

    function getMasterByType(obj){
        var id=obj.id;
        var typeName="";
//        alert(id);
        $.getJSON("/master/getMasterByTypeJson?id="+id,function(data){

            for(var nIndex=0;nIndex<data.length;nIndex++){

            };
        });
    }


</script>

<style type="text/css">

    .master-li:hover{
        cursor:pointer;
        background-color: #eee;
    }
</style>

<div id="masterModal" class="modal fade masterModal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-sm">
        <div class="modal-content model-content-master" style="height:600px;overflow:scroll;">
            <input id="master-type" type="hidden" value="" />
            <input type="hidden" id="master-class" value="" />
            <ul id="master-ul" class="list-group">
            </ul>
        </div>
    </div>
</div>

<script type="text/javascript">


    function getMasterByType(obj){
        var type=obj.value;
        var masterName = new String($(obj).attr("class"));
        var masterNames = masterName.split("master-");
        $("#master-class").val(masterNames[1]);
        var typeName="";
//        alert(id);
        $.post("/master/getMasterByTypeJson",{"type":type},function(data){
            $("#master-type").val(type);
            var masters = JSON.parse(data);

            $("#master-ul").html("");
            for(var i = 0;i<masters.length;i++){
                var tmpHTML = '<li class="list-group-item master-li" onclick="chooseThisMaster(this)">'+masters[i].ryaku+'   '+masters[i].name+'</li>'
                $("#master-ul").html($("#master-ul").html()+tmpHTML);
            }
//            console.log($('.masterModal'));
        });
    }

    function chooseThisMaster(obj) {
        $("#master-type").val();
        var masterName = $("#master-class").val();
        var values = new String(obj.innerHTML);
        var masters = values.split("   ");
        var targets = $("."+masterName);
        for(var i = 0;i<targets.length;i++){
            if(targets.length < 2){
                targets[0].value = masters[1];
                break;
            }
            targets[i].value = masters[i];
        }
    }
</script>




<c:import url="../htmlframe/leftFrame.jsp" />

</body>
</html>
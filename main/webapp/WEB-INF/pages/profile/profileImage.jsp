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
                <li class="active"><span id="username">${user.username}</span></li>
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
                <!-- collection -->

                <div class="nav-tabs-custom">
                    <!-- Tabs within a box -->
                    <ul class="nav nav-tabs pull-right">
                        <li><a href="/profile/getUserProfile">個人情報</a></li>
                        <li class="active"><a href="/profile/getUserProfileImage">写真</a></li>
                        <li class="pull-left header"><i class="fa fa-edit"></i></li>
                    </ul>
                    <input type="hidden" id="userid" value="${user.userid}"/>
                    <div class="tab-content">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-6 col-xs-12" style="text-align: center;margin-bottom: 10px">
                                    <!-- current image -->
                                    <input type="hidden" id="currentProfile" value="${user.profile}"/>
                                    <img id="profileImage" src="${imageRoot}${user.profile}" />
                                </div>
                                <div class="col-md-6 col-xs-12">
                                    <!--Add a button for the user to click to initiate auth sequence -->
                                    <button id="authorize-button" style="visibility: hidden">Authorize</button>
                                    <!-- new image -->
                                    <div class="btn btn-app btn-primary btn-file">
                                        <span class="glyphicon glyphicon-cloud-upload"></span>
                                        <span class="glyphicon-class">写真アップロード</span>
                                        <input type="file" id="filePicker" name="attachment" style="height: 70px !important;">
                                    </div>
                                    <div id="main-content">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="progress xs progress-striped active">
                            <div id="progressbar" class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
                                <span class="sr-only">60% Complete</span>
                            </div>
                        </div>
                    </div>
                </div>

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
    function progressBarController(num){
        $("#progressbar").attr({"aria-valuenow":num});
        $("#progressbar").css({"width":num+"%"});
    }
</script>

<script type="text/javascript">
/**
 * The Project ID of your Google Cloud Storage Project.
 */
var PROJECT = 'power-science-20140719001';
/**
 * Enter a client ID for a web application from the Google Developers
 * Console on the "APIs & auth", "Credentials" page.
 * In your Developers Console project add a JavaScript origin
 * that corresponds to the domain from where you will be running the
 * script. For more info see:
 * https://developers.google.com/console/help/new/#generatingoauth2
 */
var clientId = '13771198627-plrtfkpr8r96ccev7n6ip1f1ublte6n1.apps.googleusercontent.com';
/**
 * Enter the API key from the Google Developers Console, by following these
 * steps:
 * 1) Visit https://cloud.google.com/console and select your project
 * 2) Click on "APIs & auth" in the left column and then click “Credentials”
 * 3) Find section "Public API Access" and use the "API key." If sample is
 * being run on localhost then delete all "Referers" and save. Setting
 * should display "Any referer allowed." For more info see:
 * https://developers.google.com/console/help/new/#generatingdevkeys
 */
var apiKey = 'AIzaSyAG-h3cIM_SsO0fE_gA8lAIl2x71zdC6NA';
/**
 * To enter one or more authentication scopes, refer to the documentation
 * for the API.
 */
var scopes = 'https://www.googleapis.com/auth/devstorage.full_control';
/**
 * Constants for request parameters. Fill these values in with your custom
 * information.
 */
var API_VERSION = 'v1';
var BUCKET = 'valdac';
/**
 * The name of the object inserted via insertObject method.
 */
var object = "";

var GROUP =
        'group-00b4903a9744bffac3b0196718449ddbaf5cbc5a1ebfff7783546ad6f13e63f6';
/**
 * Valid values are user-userId, user-email, group-groupId, group-email,
 * allUsers, allAuthenticatedUsers
 */
var ENTITY = 'allUsers';
/**
 * Valid values are READER, OWNER
 */
var ROLE = 'OWNER';
/**
 * Valid values are READER, OWNER
 */
var ROLE_OBJECT = 'OWNER';
/**
 * Google Cloud Storage API request to insert an object into
 * your Google Cloud Storage bucket.
 */
function insertObject(event) {
    try{
        var fileData = event.target.files[0];
    }
    catch(e) {
        //'Insert Object' selected from the API Commands select list
        //Display insert object button and then exit function
        filePicker.style.display = 'none';
        return;
    }
    // progressbar
    progressBarController(10);
    const boundary = '-------314159265358979323846';
    const delimiter = "\r\n--" + boundary + "\r\n";
    const close_delim = "\r\n--" + boundary + "--";
    var reader = new FileReader();
    reader.readAsBinaryString(fileData);
    reader.onload = function(e) {
        var fileTypeOld = new String(fileData.name);
        var fileType = fileTypeOld.split('.');
        progressBarController(30);
        var contentType = fileData.type || 'application/octet-stream';
        var metadata = {
            'name': 'profile/'+fileData.name,
            'mimeType': contentType
        };
        var base64Data = btoa(reader.result);
        var multipartRequestBody =
                delimiter +
                'Content-Type: application/json\r\n\r\n' +
                JSON.stringify(metadata) +
                delimiter +
                'Content-Type: ' + contentType + '\r\n' +
                'Content-Transfer-Encoding: base64\r\n' +
                '\r\n' +
                base64Data +
                close_delim;
        //Note: gapi.client.storage.objects.insert() can only insert
        //small objects (under 64k) so to support larger file sizes
        //we're using the generic HTTP request method gapi.client.request()
        var request = gapi.client.request({
            'path': '/upload/storage/v1/b/' + BUCKET + '/o',
            'method': 'POST',
            'params': {'uploadType': 'multipart'},
            'headers': {
                'Content-Type': 'multipart/mixed; boundary="' + boundary + '"'
            },
            'body': multipartRequestBody});
        progressBarController(60);
        try{
            //Execute the insert object request
            executeRequest(request, 'insertObject');
            //Store the name of the inserted object
            object = 'profile/'+fileData.name;
        }
        catch(e) {
            alert('An error has occurred: ' + e.message);
        }
    }
}
/**
 * Google Cloud Storage API request to insert an Access Control List into
 * your Google Cloud Storage object.
 */
function insertObjectAccessControls() {
    resource = {
        'entity': ENTITY,
        'role': ROLE_OBJECT
    };
    var request = gapi.client.storage.objectAccessControls.insert({
        'bucket': BUCKET,
        'object': object,
        'resource': resource
    });
    executeRequest(request, 'insertObjectAccessControls');
}
/**
 * Google Cloud Storage API request to delete a Google Cloud Storage object.
 */
function deleteObject() {
    var request = gapi.client.storage.objects.delete({
        'bucket': BUCKET,
        'object': object
    });
    executeRequest(request, 'deleteObject');
}
function updateApiResultEntry(apiRequestName) {
    listChildren = document.getElementById('main-content')
            .childNodes;
    if (listChildren.length > 1) {
        listChildren[1].parentNode.removeChild(listChildren[1]);
    }
    if (apiRequestName != 'null') {
        window[apiRequestName].apply(this);
    }
}
function executeRequest(request, apiRequestName) {
    request.execute(function(resp) {
        console.log(resp);
        if (apiRequestName != 'insertObject') {
            document.getElementById('profileImage').src="http://storage.googleapis.com/valdac/"+resp.object;
            document.getElementById('headerProfile').src="http://storage.googleapis.com/valdac/"+resp.object;
            document.getElementById('leftProfile').src="http://storage.googleapis.com/valdac/"+resp.object;
            progressBarController(100);
            //update database
            $.post("/profile/updateUserProfileById",{"userid":document.getElementById("userid").value,"profile":resp.object},function(data){
                //delete this current profile
//                deleteObject();
                var deleteRequest = gapi.client.storage.objects.delete({
                    'bucket': BUCKET,
                    'object': document.getElementById("currentProfile").value
                });
                deleteRequest.execute(function(resp2){
                    progressBarController(0);
                });
            });
            ;
        } else {
            progressBarController(80);
            insertObjectAccessControls();
        }
    });
}
/**
 * Set required API keys and check authentication status.
 */
function handleClientLoad() {
    gapi.client.setApiKey(apiKey);
    window.setTimeout(checkAuth, 1);
}
/**
 * Authorize Google Cloud Storage API.
 */
function checkAuth() {
    gapi.auth.authorize({
        client_id: clientId,
        scope: scopes,
        immediate: true
    }, handleAuthResult);
}
/**
 * Handle authorization.
 */
function handleAuthResult(authResult) {
    var authorizeButton = document.getElementById('authorize-button');
    if (authResult && !authResult.error) {
        authorizeButton.style.visibility = 'hidden';
        initializeApi();
        filePicker.onchange = insertObject;
    } else {
        authorizeButton.style.visibility = '';
        authorizeButton.onclick = handleAuthClick;
    }
}
/**
 * Handle authorization click event.
 */
function handleAuthClick(event) {
    gapi.auth.authorize({
        client_id: clientId,
        scope: scopes,
        immediate: false
    }, handleAuthResult);
    return false;
}
/**
 * Load Google Cloud Storage API v1beta12.
 */
function initializeApi() {
    gapi.client.load('storage', API_VERSION);
}
/**
 * Driver for sample application.
 */
$(window)
        .bind('load', function() {
//            addSelectionSwitchingListeners();
            handleClientLoad();
        });

</script>

<c:import url="../htmlframe/footerFrame.jsp" />


</body>
</html>
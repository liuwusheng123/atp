<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String domain = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path;
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="description" content="Xenon Boostrap Admin Panel" />
<meta name="author" content="" />
<title>自动化测试系统</title>
<link rel="Shortcut Icon" href="<%=path%>/images/favicon.ico" />
<link rel="stylesheet"
	href="<%=path%>/css/fonts/fontawesome/css/font-awesome.min.css">
<link rel="stylesheet" href="<%=path%>/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=path%>/css/xenon-core.css">
<link rel="stylesheet" href="<%=path%>/css/animation.css">
<link rel="stylesheet" href="<%=path%>/css/tou-style.css">
<script src="<%=path%>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/common/page.js"></script>
<script type="text/javascript">
	var path='<%=path%>';
	function edit(id){
		var data={};
		data.sid=id;
		var url=path+"/testservice/selectById.do";
		ajaxReq(data, url, showSingle, "post");
	}
	function showSingle(result){
		var data=result.obj;
		$("#servicename2").val(data.service_name);
		$("#serviceid2").val(data.service_id);
		$("#servicedes2").val(data.service_des);
		$("#isrun2").val(data.is_run);
		$(".edit").modal("show");
	}
	
	function del(id,name) {
		$(".dele").modal("show");
		$("#servicename3").html(name);
		$("#delyes").unbind("click").click(function() {
			$('.dele').modal('hide');
			var data = {};
			data.sid = id;
			data.sname = name;
			var url = path + "/testservice/deleteById.do";
			ajaxReq(data, url, doCall, "post");
		});
	}
	function chBlur(a, b, c) {
		if ($("#" + a).val() == "") {
			$("#" + b).html(c)
			return false;
		}
		$("#" + b).html("")
		return true;
	}
	function doCall(result){
		//alert(result.obj);
		$("#servicename3").html(result.obj);
		$(".xinxi").modal('show');

	}
	function skipIndex(){
		window.location.href=path+"/testservice/index.do"
	}
	function hrefMethodIndex(id){
		window.location.href=path+"/testmethod/selectByServiceId.do?sid="+id
	}
	function addBefore() {
		$(".xinz").modal("show");
		var data = {};
		var url = path + "/testservice/addBefore.do";
		ajaxReq(data, url, addBeforecall, "get");
	}
	function addBeforecall(result) {
		var data = result.obj;
		var options = "";
		for(var i=0;i<data.length;i++){
			options+=("<option value='"+data[i]+"'>"+data[i]+"</option>");
			}
		$("#unCreateService").html(options);
	}
	function add() {
		var data = {};
		data.service_name = $("#unCreateService").val();
		data.service_des = $("#servicedes").val();
		data.is_run = $("#isrun").val();
		var url = path + "/testservice/add.do";
		ajaxReq(data, url, doCall, "post");
	}
	function update(){
		if (!(chBlur('servicename', 'servicename1', '服务描述不能为空')
				 )) {
			return;
		}
		var data = {};
		data.service_id = $("#serviceid2").val();
		data.service_name = $("#servicename2").val();
		data.service_des = $("#servicedes2").val();
		data.is_run = $("#isrun2").val();
		var url = path + "/testservice/updateById.do";
		ajaxReq(data, url, doCall, "post");
	}
	
	
</script>
</head>
<body class="page-body">
<input type="hidden" value="${params }" id="skipParam">
	<div class="page-container">
		<!--progress-->
		<%@include file="../common/left-menu.jsp"%>
		<div class="main-content">
			<div class="topv">
				<h3>测试服务</h3>
			</div>
			<div class="row" style="padding-top: 50px;">
				<div class="col-md-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<!--<div class="panel-options"> <a href="#"> <i class="linecons-cog"></i> </a> <a href="#" data-toggle="panel"> <span class="collapse-icon">–</span> <span class="expand-icon">+</span> </a> <a href="#" data-toggle="reload"> <i class="fa-rotate-right"></i> </a> <a href="#" data-toggle="remove"> × </a> </div>-->
						</div>
						<div class="screen">
						<form action="<%=path %>/testcase/index.do" id="payForm" method="post">
							<ul class="shaix clearfix">
								<li><span>测试服务：</span> <select name="initserviceselect">
										<option value="">全部服务</option>
										<c:forEach items="${serviceList }" var="item">
											<option value="${item.service_name }" <c:if test="${item.service_name !=null }">selected</c:if> >${item.service_name }</option>
										</c:forEach>
								</select></li>
								<li><a href="javascript:void(0)" class="sxbtn" onclick="query()"> <span
										class="glyphicon glyphicon-search"></span> 筛选
								</a></li>
								<li>
									<button type="button" class="addnew" onclick="addBefore()">新增</button>
								</li>
							</ul>
						</form>
						</div>

						<div class="table-responsive">
							<table class="table table-bordered">
								<tr>
									<th>服务id</th>
									<th>服务名称</th>
									<th>服务描述</th>
									<th>是否运行</th>
									<th>操作</th>
								</tr>
								<c:forEach var="item" items="${serviceList }">
									<tr class="">
										<td>${item.service_id }</td>
										<td>${item.service_name }</td>
										<td>${item.service_des }</td>
										<td>${item.is_run }</td>
										<td>
											<a href="javascript:edit('${item.service_id}')">编辑</a>
											<a href="javascript:del('${item.service_id }','${item.service_name }')">删除</a>
											<a href="javascript:hrefMethodIndex('${item.service_id}')">方法</a>
										</td>
									</tr>
								</c:forEach>
							</table>
						</div>
						<%@include file="../common/page.jsp" %>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 新增 -->
	<div class="modal fade xinz" tabindex="-1" role="dialog"
		aria-labelledby="mySmallModalLabel">
		<div class="modal-dialog xinzm">
			<div class="modal-content">
				<div class="xzmain">
					<h3>测试服务-新增</h3>
					<div class="bwarp">
							<ul>
							<li class="clearfix bgwhite">
								<div class="fp">
									<span><strong>*</strong>服务名称:</span> <select id="unCreateService"></select>
								</div>
								<div class="fp">
									<span><strong>*</strong>服务id:</span> <input type="text"	id="serviceid"  disabled="disabled"/>
								</div>
							</li>
							<li class="clearfix bgwhite">
								<div class="fp">
									<span><strong>*</strong>服务描述:</span> <input type="text" id="servicedes" onblur="chBlur('servicedes','servicedes1','服务描述不能为空')"/><span id="servicedes1" style="color: red;font-size:13px"></span>
								</div>						
								<div class="fp">
									<span><strong>*</strong>是否运行:</span>
									<select id="isrun" >
										<option value="1">YES</option>
										<option value="0">NO</option>
									</select>
								</div>
							</li>
						</ul>
						<div class="modal-footer">
							<p>
								<button type="button" class="save" onclick="add()">保存</button>
								<button type="button" class="closebtn" data-dismiss="modal">取消</button>
							</p>
						</div>


					</div>
				</div>

			</div>
		</div>
	</div>
	
	

	<!-- 修改 -->
	<div class="modal fade edit" tabindex="-1" role="dialog"
		aria-labelledby="mySmallModalLabel">
		<div class="modal-dialog xinzm">
			<div class="modal-content">
				<div class="xzmain">
					<h3>测试服务-编辑</h3>
					<div class="bwarp">
							<ul>
							<li class="clearfix bgwhite">
								<div class="fp">
									<span><strong>*</strong>服务名称:</span> <input type="text"	id="servicename2"  disabled="disabled"/>
								</div>
								<div class="fp">
									<span><strong>*</strong>服务id:</span> <input type="text"	id="serviceid2"  disabled="disabled"/>
								</div>
							</li>
							<li class="clearfix bgwhite">
								<div class="fp">
									<span><strong>*</strong>服务描述:</span> <input type="text" id="servicedes2" onblur="chBlur('servicedes','servicedes1','服务描述不能为空')"/><span id="servicedes1" style="color: red;font-size:13px"></span>
								</div>						
								<div class="fp">
									<span><strong>*</strong>是否运行:</span>
									<select id="isrun2" >
										<option value="1">YES</option>
										<option value="0">NO</option>
									</select>
								</div>
							</li>
						</ul>
						<div class="modal-footer">
							<p>
								<button type="button" class="save" onclick="update()">编辑</button>
								<button type="button" class="closebtn" data-dismiss="modal">取消</button>
							</p>
						</div>


					</div>
				</div>

			</div>
		</div>
	</div>
	
	<!-- 修改成功后的提示 -->
	<div class="modal fade xinxi" id="" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">信息提示</h4>
				</div>
				<div class="modal-body">
					<div class="xints">
						<h4 id="msg"></h4>
						<p>
							<span>测试服务:<strong id="servicename3"></strong></span>
						</p>
					</div>
				</div>
				<div class="modal-footer">
					<p>
						<button type="button" class="save" data-dismiss="modal" onclick="skipIndex()">确认</button>
					</p>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 删除提示 -->
	<div class="modal fade dele" id="" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">信息提示</h4>
				</div>
				<div class="modal-body">
					<div class="xints">
						<h4>是否删除</h4>
						<p>
							<span>测试服务:<strong id="servicename3"></strong></span>
						</p>
					</div>
				</div>
				<div class="modal-footer">
					<p>
						<button type="button" class="save" id="delyes">是</button>
						<button type="button" class="closebtn" data-dismiss="modal">取消</button>
					</p>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Bottom Scripts -->
	<script src="<%=path%>/js/bootstrap.min.js"></script>
	<script src="<%=path%>/js/TweenMax.min.js"></script>
	<!--<script src="<%=path%>/js/joinable.js"></script>
	<script src="<%=path%>/js/xenon-api.js"></script>-->
	<script src="<%=path%>/js/resizeable.js"></script>
	<script src="<%=path%>/js/xenon-toggles.js"></script>
	<script src="<%=path%>/js/checkbox.js"></script>
	<!--JavaScripts initializations and stuff -->
	<script src="<%=path%>/js/xenon-custom.js"></script>
	<script src="<%=path%>/js/datePicker/wdatePicker.js"></script>
</body>
</html>
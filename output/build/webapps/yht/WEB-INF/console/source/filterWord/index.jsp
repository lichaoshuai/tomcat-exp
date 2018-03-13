<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/include/include.jsp"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="${path }/js/easyui/window.js"></script>
		<link rel="stylesheet" type="text/css" href="${path }/css/buttonPanel.css">
		<title>字符过滤</title>
		<script type="text/javascript">
			var win,table;
			$(document).ready(function(){
				getColorStyle();
				win = new Jwindow(function(table){table.datagrid('reload');});
				table = $('#dataTable').datagrid({
					url:'${path}/source/forbiddenWord!list.qt?random='+getRandomNum(),
					width:document.body.clientWidth,
					height:document.body.clientHeight-$('.buttonPanel').height()-9,
					idField:'id',
					pagination:true,
					nowrap:true,
					border:false,
					striped:true,
					fitColumns:true,
					rownumbers:true,
					clickSingleSelect:true,
					columns:[[
						{field:'ck',checkbox:true,width:100},
						{field:'forbiddenWord',width:500,title:'过滤字符'}
					]],
					onHeaderContextMenu: function(e, field){
						e.preventDefault();
						if (!$('#tmenu').length){
							createColumnMenu(table);
						}
						$('#tmenu').menu('show', {
							left:e.pageX,
							top:e.pageY
						});
					}
				});
			});
			
			function buttonDisable(){
				$("#queryBtn").linkbutton({disabled:false});
			}
		</script>
	</head>
	<body>
		<div class="buttonPanel">
			<div class="formPanel">
				<label for=forbiddenWord.forbiddenWord>过滤字符：</label>
				<input type="text" name="forbiddenWord.forbiddenWord" id="forbiddenWord.forbiddenWord" style="float:left;"/>
				<div class="clear"></div>
			</div>
			<fs:button key="NEWADD" id="addButton" name="新增" iconCls="icon-add">
				function(){
					win.show('新增过滤字符','${path}/source/forbiddenWord!preAdd.qt?chkAccess='+encodeURIComponent('{#chkAccess}')+'&random='+getRandomNum(),table);
					win.reSize(500,200);
				}
			</fs:button>
			<fs:button key="MODIFY" id="modifyButton" name="修改" iconCls="icon-edit">
				function(){
					var rows = table.datagrid('getSelections');
					if(rows && 1!=rows.length){parent.jQuery.messager.alert('错误','对不起！请选择将要修改的一条记录！','error');return;}
					win.show('修改过滤字符','${path}/source/forbiddenWord!preModify.qt?forbiddenWord.id='+rows[0].id+'&chkAccess='+encodeURIComponent('{#chkAccess}')+'&random='+getRandomNum(),table);
					win.reSize(500,200);
				}
			</fs:button>
			<fs:button key="DELETE" id="deleteButton" name="删除" iconCls="icon-remove">
				function(){
					var rows = table.datagrid('getSelections');
					if(rows!=null&&rows.length!=0) {
						//var str;
						//if(rows[0].forbiddenWord.trim().length>5){
						//	str=rows[0].forbiddenWord.trim().substring(0,5)+"...";
						//}else{
						//	str=rows[0].forbiddenWord.trim();
						//}
						var ids="";
						for(var i=0;i < rows.length;i++){
								ids+=","+rows[i].id;
						}
						jQuery.messager.confirm('提示','确定删除选中的过滤字符吗？',function(b){
							if(b){
								jQuery.ajax({
									async: false,
									type: "GET",
									url: '${path}/source/forbiddenWord!delete.qt?ids='+ids+'&chkAccess='+encodeURIComponent('{#chkAccess}')+'&random='+getRandomNum(),
									success: function(data){
										data = eval(data);
										if(data&&data.b){}else jQuery.messager.alert('错误','删除失败，请刷新页面重试！','error');
										table.datagrid('reload');
										table.datagrid('clearSelections');
									}
								});
							}
						});
					}else{
						parent.jQuery.messager.alert('错误','对不起！请选择将要删除的记录！','error');
					}
				}
			</fs:button>
			<fs:button key="QUERY" id="queryBtn" name="查询" iconCls="icon-search">
				function(){
					var params = getURLParams();
					$(this).linkbutton({disabled:true});
					table.datagrid('options').url='${path}/source/forbiddenWord!list.qt?chkAccess='+encodeURIComponent('{#chkAccess}')+'random='+getRandomNum()+params;
					table.datagrid('reload');
					table.datagrid('clearSelections');
					setTimeout("buttonDisable()",BUTTON_WAIT_TIME);
				}
			</fs:button>
			<div class="datagrid-btn-separator" style="visibility:hidden;"></div>
			<div class="clear"></div>
		</div>
		<table id="dataTable"></table>
	</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/include.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>修改操作员</title>
	<style type="text/css">
		body{padding:10px;background:#fafafa;overflow:hidden;}
		th{width:80px;height:30px;line-height:30px;text-align:right;font-size:9pt;font-weight:normal;}
		td{height:30px;line-height:30px;font-size:9pt;}
	</style>
	<script type="text/javascript">
		jQuery(document).ready(function(){
			$(document.getElementById('operator.organ.id')).combotree({
				url:"${path}/base/organ!getJson.qt?chkAccess=${param.chkAccess}",
				check:function(node){
					//return node.attributes.isUnit!=1;
					return true;
				}
			});
		});
		function submitForm(el){
			$('#newForm').form('submit',{
				url:'${path}/base/account!modify.qt?random='+getRandomNum(),
				onSubmit:function(){
					var b = $(this).form('validate');
					if(b) $(el).linkbutton({disabled:true});
					return b;
				},
				success:function(data){
					$(el).linkbutton({disabled:false});
					try{
						var obj = eval(data);
						if(obj.b){
							if(''!=jQuery.trim(obj.desc)){
								parent.jQuery.messager.alert('提示','修改成功!<br/><br/><span color="green">'+obj.desc+'</span>','info');
							}
							if(parent&&parent.win) parent.win.refreshParent();
						}else parent.jQuery.messager.alert('错误','<br/>修改失败！','error');
					}catch(e){parent.jQuery.messager.alert('错误',e.message+'<br/><br/>修改失败！','error');}
				},
				onLoadError:function(e){
					$(el).linkbutton({disabled:false});
					parent.jQuery.messager.alert('错误',e.message+'<br/><br/>保存失败！','error');
				}
			});
		}
		function reset(){
			newForm.reset();
		}
	</script>
	</head>
	<body>
		<form id="newForm" name="newForm" method="post">
			<input type="hidden" name="chkAccess" value="${param.chkAccess }">
			<input type="hidden" name="operator.id" value="${item.id }"/>
			<table style="width:100%;table-layout:fixed;" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<th>账号：</th>
	    			<td>
	    				<input type="text" id="operator.account" name="operator.account" value="${item.account}" class="easyui-validatebox" required="true" readonly="readonly" validType="exist['${path }/base/account!accountExist.qt?chkAccess=${param.chkAccess}','${item.account}']" maxlength="30" style="width:200px;"/>
	    			</td>
	    		</tr>
				<tr>
					<th>编号：</th>
					<td>
						<input type="text" name="operator.scode" id="operator.scode" value="${item.scode}" class="easyui-validatebox"  maxlength="50" style="width:200px;"/>
					</td>
				</tr>
	    		<tr>
	    			<th>姓名：</th>
	    			<td>
	    				<input type="text" id="operator.userName" name="operator.userName" value="${item.userName}" maxlength="30" style="width:200px;" class="easyui-validatebox" required="true"/>
	    			</td>
	    		</tr>
	    		<tr>
	    			<th>性别：</th>
	    			<td>
						<input type="radio" name="operator.sex" value="1" <c:if test="${item.sex == 1}">checked="checked"</c:if>>
						<label for="status">男</label>
	    				<input type="radio" name="operator.sex" value="0" <c:if test="${item.sex == 0}">checked="checked"</c:if>>
	    				<label for="status">女</label>
	    			</td>
	    		</tr>
	    		<tr>
	    			<th>手机：</th>
	    			<td>
	    				<input type="text" id="operator.mobile" name="operator.mobile" value="${item.mobile}" style="width:200px;" class="easyui-validatebox" validType="mobile" maxlength="11" required="true"/>
	    			</td>
	    		</tr>
	    		<tr>
	    			<th>生日：</th>
	    			<td>
	    				<input type="text" id="operator.birthday" name="operator.birthday" value="<fmt:formatDate value="${item.birthday}" pattern="yyyy-MM-dd"/>"  style="width:200px;" onfocus="WdatePicker()" class="easyui-validatebox" methodType="chooseDate"/>
	    			</td>
	    		</tr><c:if test="${1 eq item.id}">
	    		<tr>
	    			<th>所属组织：</th>
	    			<td><c:catch>
	    				<input type="text" value="${item.organ.orgnName}" readonly="readonly" style="width:200px;"></c:catch>
	    			</td>
	    		</tr></c:if><c:if test="${1 ne item.id}">
	    		<tr>
	    			<th>所属组织：</th>
	    			<td>
	    				<input type="text" id="operator.organ.id" name="operator.organ.id" value="${item.organ.id}" showText="${item.organ.orgnName}" class="easyui-combotree" required="true" style="width:290px;">
	    			</td>
	    		</tr></c:if>
	    		<tr>
	    			<td colspan="2" style="height:1%;line-height:20px;padding-top:5px;">
	    				<ul>
	    					<li>账号不能被修改！</li>
	    				</ul>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td colspan="2" align="center" height="40" valign="bottom">
	    				<a href="#" onclick="submitForm(this);" class="easyui-linkbutton" plain="false" iconCls="icon-save" style="margin-right:10px">保存</a>
	    				<a href="javascript:reset();" class="easyui-linkbutton" plain="false" iconCls="icon-remove">重置</a>
	    			</td>
	    		</tr>
	    	</table>
	    </form>
	</body>
</html>
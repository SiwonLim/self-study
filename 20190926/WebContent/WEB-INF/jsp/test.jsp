<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입 & 조회</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="././resources/css/datatable.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	// Activate tooltip
	$('[data-toggle="tooltip"]').tooltip();
	
	// Select/Deselect checkboxes
	var checkbox = $('table tbody input[type="checkbox"]');
	$("#selectAll").click(function(){
		if(this.checked){
			checkbox.each(function(){
				this.checked = true;                        
			});
		} else{
			checkbox.each(function(){
				this.checked = false;                        
			});
		} 
	});
	checkbox.click(function(){
		if(!this.checked){
			$("#selectAll").prop("checked", false);
		}
	});
});
</script>

<!-- table에 data 삽입 -->
<script type="text/javascript">
var delNum=0;
var listSize=0;
var items = {//enum
		'id':0,'firstname' : 1,'lastname' : 2,'username' : 3,
		'email' : 4,'gender' : 5,'pwd' : 6,
		'cpwd' : 7
};
//컬럼정보 불러오기
function getColumn(){
	$.ajax({
		url : 'getColumn',
		success : function(data){
			var str="";
			var size=Object.keys(data).length;
			if(size>0){
				for(let i = 0 ; i < size ; i++){
					if(i==items.pwd) continue;
					str+='<th>'+data[i].column_name+'</th>';
				}
				str+='<th>'+'Actions'+'</th>';
				$('#columns').append(str);
				getData();
			}
			else{
				alert("컬럼이 비었습니다");
			}
		},
		error : function(){
			alert("error");
		}
	});
}
//목록에 있는 정보 수정()
function modify(idNum){
	alert(idNum);
	//$('#editEmployeeModal').modal().$('#item_0').val("nooo");
	$('#data').val(idNum);
	$('#form').submit();
}
//db에서 데이터 가져오기
function getData(){
	$.ajax({
		url : 'getData',
		success : function(data){
			var str="";
			listSize=Object.keys(data).length;
			if(listSize>0){
				for(let i = 0 ; i < listSize ; i++){
					str+="<tr><td><span class='custom-checkbox'><input type='checkbox' id='checkbox1' name='options[]' value='1'><label for='checkbox1'></label></span></td>";
					str+='<td>'+data[i].id+'</td>';
					str+='<td>'+data[i].firstname+'</td>';
					str+='<td>'+data[i].lastname+'</td>';
					str+='<td>'+data[i].username+'</td>';
					str+='<td>'+data[i].email+'</td>';
					str+='<td>'+data[i].gender+'</td>';
					str+='<td>'+data[i].mdate+'</td>';
					str+='<td>';
					//str+="<a href='javascript:modify("+data[i].id+");' class='edit'><i class='material-icons' data-toggle='tooltip' title='Edit'>&#xE254;</i></a>";
					str+="<a href='javascript:doDelete("+data[i].id+");' class='delete'><i class='material-icons' data-toggle='tooltip' title='Delete'>&#xE872;</i></a>";
					str+='</td>';
					str+='</tr>';
				}
				$('#tbody').append(str);
				$('#test').text(listSize);
			}
		},
		error : function(){
			alert("error");
		}
	});
}
function doDelete(dyDelNum){
	delNum=dyDelNum;
	if(confirm('데이터를 정말 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.')){
        $.ajax({
        	type : 'POST',
        	url : 'delData',
        	data : {'id':delNum},
        	success:function(data){
        		location.reload();
        	},error:function(){
        		alert("error");
        	}
        });
    }
	//$('#deleteEmployeeModal').modal();
}

//초기화-데이터 가져오기
getColumn();
</script>
</head>
<body>
    <div class="container">
        <div class="table-wrapper">
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-6">
						<h2>Data table <b>form</b></h2>
					</div>
					<div class="col-sm-6">
						<a href="/20190926/index" class="btn btn-success" data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Add New Employee</span></a>
						<a href="#deleteEmployeeModal" class="btn btn-danger" data-toggle="modal"><i class="material-icons">&#xE15C;</i> <span>Delete</span></a>						
					</div>
                </div>
            </div>
            <table class="table table-striped table-hover">
                <thead>
                    <tr id=columns>
						<th>
							<span class="custom-checkbox">
								<input type="checkbox" id="selectAll">
								<label for="selectAll"></label>
							</span>
						</th>
						<!-- 
	                        <th>id</th>
	                        <th>First Name</th> 
							<th>Last Name</th>
	                        <th>Username</th>
	                        <th>Email Address</th>
	                        <th>Gender</th>-->
                    </tr>
                </thead>
                <tbody id="tbody">
                    <!--<tr>
						<td>
							<span class="custom-checkbox">
								<input type="checkbox" id="checkbox1" name="options[]" value="1">
								<label for="checkbox1"></label>
							</span>
						</td>
                        <td>Thomas Hardy</td>
                        <td>thomashardy@mail.com</td>
						<td>89 Chiaroscuro Rd, Portland, USA</td>
                        <td>(171) 555-2222</td>
                        <td>Email Address</td>
                        <td>Gender</td>
                        <td>
                            <a href="#editEmployeeModal" class="edit" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i></a>
                            <a href="#deleteEmployeeModal" class="delete" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></a>
                        </td>
                    </tr>
                    <tr>
						<td>
							<span class="custom-checkbox">
								<input type="checkbox" id="checkbox2" name="options[]" value="1">
								<label for="checkbox2"></label>
							</span>
						</td>
                        <td>Dominique Perrier</td>
                        <td>dominiqueperrier@mail.com</td>
						<td>Obere Str. 57, Berlin, Germany</td>
                        <td>(313) 555-5735</td>
                        <td>
                            <a href="#editEmployeeModal" class="edit" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i></a>
                            <a href="#deleteEmployeeModal" class="delete" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></a>
                        </td>
                    </tr>
					<tr>
						<td>
							<span class="custom-checkbox">
								<input type="checkbox" id="checkbox3" name="options[]" value="1">
								<label for="checkbox3"></label>
							</span>
						</td>
                        <td>Maria Anders</td>
                        <td>mariaanders@mail.com</td>
						<td>25, rue Lauriston, Paris, France</td>
                        <td>(503) 555-9931</td>
                        <td>
                            <a href="#editEmployeeModal" class="edit" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i></a>
                            <a href="#deleteEmployeeModal" class="delete" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></a>
                        </td>
                    </tr>
                    <tr>
						<td>
							<span class="custom-checkbox">
								<input type="checkbox" id="checkbox4" name="options[]" value="1">
								<label for="checkbox4"></label>
							</span>
						</td>
                        <td>Fran Wilson</td>
                        <td>franwilson@mail.com</td>
						<td>C/ Araquil, 67, Madrid, Spain</td>
                        <td>(204) 619-5731</td>
                        <td>
                            <a href="#editEmployeeModal" class="edi1t" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i></a>
                            <a href="#deleteEmployeeModal" class="delete" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></a>
                        </td>-->
                    </tr>					
                </tbody>
            </table>
			<div class="clearfix">
                <div class="hint-text">Showing <b id="test"></b> out of <b>25</b> entries</div>
                <ul class="pagination">
                    <li class="page-item disabled"><a href="#">Previous</a></li>
                    <li class="page-item active"><a href="#" class="page-link">1</a></li>
                    <li class="page-item"><a href="#" class="page-link">2</a></li>
                    <li class="page-item"><a href="#" class="page-link">3</a></li>
                    <li class="page-item"><a href="#" class="page-link">4</a></li>
                    <li class="page-item"><a href="#" class="page-link">5</a></li>
                    <li class="page-item"><a href="#" class="page-link">Next</a></li>
                </ul>
            </div>
        </div>
    </div>
	<!-- Edit Modal HTML -->
	<div id="addEmployeeModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form>
					<div class="modal-header">						
						<h4 class="modal-title">Add Employee</h4>
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body">					
						<div class="form-group">
							<label>firstName</label>
							<input id="item_0" type="text" class="form-control" required>
						</div>
						<div class="form-group">
							<label>Email</label>
							<input type="email" class="form-control" required>
						</div>
						<div class="form-group">
							<label>Address</label>
							<textarea class="form-control" required></textarea>
						</div>
						<div class="form-group">
							<label>Phone</label>
							<input type="text" class="form-control" required>
						</div>					
					</div>
					<div class="modal-footer">
						<input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
						<input type="submit" class="btn btn-success" value="Add">
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- Edit Modal HTML -->
	<div id="editEmployeeModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form>
					<div class="modal-header">						
						<h4 class="modal-title">Edit Data</h4>
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body">					
						<div class="form-group">
							<label>Name</label>
							<input id="item_0" type="text" value="test" class="form-control" required>
						</div>
						<div class="form-group">
							<label>Email</label>
							<input type="email" class="form-control" required>
						</div>
						<div class="form-group">
							<label>Address</label>
							<textarea class="form-control" required></textarea>
						</div>
						<div class="form-group">
							<label>Phone</label>
							<input type="text" class="form-control" required>
						</div>					
					</div>
					<div class="modal-footer">
						<input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
						<input type="button" class="btn btn-info" value="Save">
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- Delete Modal HTML -->
	<div id="deleteEmployeeModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form id='deleteData'>
					<div class="modal-header">						
						<h4 class="modal-title">Delete data</h4>
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body">					
						<p>데이터를 정말 삭제하시겠습니까?</p>
						<p class="text-warning"><small>이 작업은 되돌릴 수 없습니다.</small></p>
					</div>
					<div class="modal-footer">
						<input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
						<input type="submit" class="btn btn-danger" data-dismiss="modal" value="Delete">
					</div>
				</form>
			</div>
		</div>
	</div>
	<form id="form" method="post" action="editData">
	<input name="id" id="data" type="text" hidden>
	</form>
</body>
</html>                                		                            
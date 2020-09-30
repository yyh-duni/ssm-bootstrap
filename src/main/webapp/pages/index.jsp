<%@ page language="java" contentType="text/html; charset=UTF-8"
               pageEncoding="UTF-8" %>
    <%
    String path = request.getContextPath();
    request.setAttribute("path", path);
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <title>所有图书</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">

    <link href="http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet">

    <%--    引入jQuery--%>
    <script type="text/javascript" src="${path}/statics/js/jquery-3.3.1.js"></script>

    <%--    引入bootstrapjscss--%>
    <link href="${path}/statics/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="${path}/statics/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <%--    引入tablejscss--%>
    <link href="${path}/statics/bootstrap-3.3.7-dist/css/bootstrap-table.min.css" rel="stylesheet">
    <script type="text/javascript" src="${path}/statics/bootstrap-3.3.7-dist/js/bootstrap-table.min.js"></script>
    <%--    引入下拉列表框--%>
    <link href="${path}/statics/bootstrap-3.3.7-dist/css/bootstrap-select.min.css" rel="stylesheet">
    <script type="text/javascript" src="${path}/statics/bootstrap-3.3.7-dist/js/bootstrap-select.min.js"></script>
    <%--    引入时间插件--%>
    <link href="https://cdn.bootcss.com/bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/moment.js/2.24.0/moment-with-locales.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap-datetimepicker/4.17.47/js/bootstrap-datetimepicker.min.js"></script>

</head>
<body>
<div class="panel-body" style="padding-bottom:0px;">
    <div class="panel panel-default">
        <div class="panel-heading">查询条件</div>
        <div class="panel-body">
            <form id="formSearch" class="form-horizontal">
                <div class="form-group" style="margin-top:15px">
                    <label class="control-label col-sm-1" for="sbookId">图书编号</label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control" id="sbookId">
                    </div>
                    <label class="control-label col-sm-1" for="sbookName">图书名称</label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control" id="sbookName">
                    </div>
                    <label class="control-label col-sm-1" for="spublishId">出版社</label>
                    <div class="col-sm-3">
                        <select  class="form-control selectpicker" id="spublishId">
                            <option value="-1">请选择</option>
                        </select>
                    </div>
                    <div class="col-sm-4" style="text-align:left;">
                        <button type="button" style="margin-left:50px" id="btn_query" class="btn btn-primary">查询</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

    <div id="toolbar" class="btn-group">
        <button id="btn_add" type="button" class="btn btn-default">
            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
        </button>
        <button id="btn_delete" type="button" class="btn btn-default">
            <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>批量删除
        </button>
    </div>

<table id="table" class="table table-striped table-bordered"></table>
<%@include file="update.jsp"%>
<script type="text/javascript">
    var result ;
    $(function () {

        //1.初始化Table
        var oTable = new TableInit();
        oTable.Init();

        //2.初始化Button的点击事件
        var oButtonInit = new ButtonInit();
        oButtonInit.Init();
        //初始化下拉列表框
        $('#spublishId').selectpicker({});
        $.ajax({
            url:'${path}/bs/pubs',
            type:'GET',
            dataType:'json',
            success:function(data){
                result = data;
                var content = "";
                $.each(data,function(i,v){
                    content += "<option value='"+v.pubId+"'>"+v.pubName+"</option>";
                });
                $("#spublishId").append(content);
                $('#spublishId').selectpicker('refresh');
            },
            error:function(msg){
                console.log(msg);
            }
        });

        //点击条件查询
        $('#btn_query').click(function(){
            $('#table').bootstrapTable("destroy");
            var oTable = new TableInit();
            oTable.Init();
        });


        //点击添加
        $("#btn_add").click(function(){
            $('#uppublishId').selectpicker({
            });
            $('#uppublishId').html("");
            var content = "<option value='-1'>请选择</option>";
            for (var i = 0; i <result.length ; i++) {
                content+="<option value='"+result[i].pubId+"'>"+result[i].pubName+"</option>";
            }
            $('#uppublishId').html(content);
            //初始化刷新数据
            $('#uppublishId').selectpicker('refresh');
            $('#uppublishId').selectpicker('render');
            $("#upModal").modal("show");
            $("#myFrm").attr("action","${path}/bs/doAdd");
            $("#myFrm").find("input[name='_method']").remove();
            $("#myModalLabel").html("添加图书");
        });
        //点击删除
        $("#btn_delete").click(function(){
            var rows = $("#table").bootstrapTable("getSelections");
            if(rows.length==0){
                alert("必须选中行才可以删除！");
                return ;
            }
            var ids = new Array();
            $.each(rows,function(i,v){
                ids[i] = v.bookId;
            });
            console.log(ids);
            var r =confirm("确定要删除吗？");
            if(r){
                $.ajax({
                    url:'${path}/bs/doDelAll',
                    data:{_method:'DELETE',ids:ids},
                    type:'POST',
                    dataType:'json',
                    success:function(data){
                        $('#table').bootstrapTable("destroy");
                        var oTable = new TableInit();
                        oTable.Init();
                    }
                });

            }
        });

        //点击上传
        $("#upload").click(function(){
            //判断是否选中一个文件
            if($("#photoFile").val() == ""){
                alert('必须选择图片！');
                return;
            }
            //封装传给后台的数据
            var formData = new FormData();//虚拟出来一个表单数据
            formData.append("photo",document.getElementById("photoFile").files[0]);
            $.ajax({
                url:'${path}/bs/doUpload',
                type:'POST',
                data:formData,
                contentType: false,
                processData: false,
                dataType:'json',
                success:function(result){

                    $("#preview_photo").attr("src",result.filePath+result.fileName);
                    $("#pic").val(result.fileName);

                },
                error:function(msg){
                    console.log(msg);
                }
            });


        });


    });

    var TableInit = function () {
        var oTableInit = new Object();
        //初始化Table
        oTableInit.Init = function () {
            $('#table').bootstrapTable({
                url: '${path}/bs/findall',         //请求后台的URL（*）
                method: 'get',                      //请求方式（*）
                toolbar: '#toolbar',                //工具按钮用哪个容器
                striped: true,                      //是否显示行间隔色
                cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                pagination: true,                   //是否显示分页（*）
                sortable: false,                     //是否启用排序
                sortOrder: "asc",                   //排序方式
                queryParams: oTableInit.queryParams,//传递参数（*）
                sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
                pageNumber:1,                       //初始化加载第一页，默认第一页
                pageSize: 3,                       //每页的记录行数（*）
                pageList: [3, 6, 9, 12],        //可供选择的每页的行数（*）
                search: true,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
                strictSearch: true,
                showColumns: true,                  //是否显示所有的列
                showRefresh: false, //是否显示刷新按钮

                smartDisplay:false,
                minimumCountColumns: 2,             //最少允许的列数
                clickToSelect: true,                //是否启用点击选中行
                height: 500,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
                uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
                showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
                cardView: false,                    //是否显示详细视图
                detailView: false,                   //是否显示父子表
                columns: [
                    {checkbox:true},
                    {
                        field: 'bookId',
                        title: '图书编号'
                    },
                    {
                        field: 'bookName',
                        title: '图书名称'
                    }, {
                        field: 'publish.pubName',
                        title: '出版社'
                    }, {
                        field: 'createDate',
                        title: '日期'
                    },
                    {
                        field: 'pic',
                        title: '图片',
                        formatter: function (value, row, index) {
                            var image = '<div class="photos">'
                                +'<img style="width: 50px;height: 50px;margin: auto" alt="image" class="feed-photo" src="/upimg/' + row.pic + '"/>'
                                + '</div>';
                            return image;
                        }
                    },
                    {
                        field: 'Button',
                        title: '操作',
                        events:operateEvents,
                        formatter:AddFunctions
                    }]
            });
        };
        //得到查询的参数
        oTableInit.queryParams = function (params) {
            var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                pageSize: params.limit,   //页面大小
                pageNum: params.offset/params.limit+1,  //页码
                bookId: $("#sbookId").val(),
                bookName: $("#sbookName").val(),
                publishId:$("#spublishId").val()
            };
            return temp;
        };
        return oTableInit;
    };


    var ButtonInit = function () {
        var oInit = new Object();
        var postdata = {};

        oInit.Init = function () {
            //初始化页面上面的按钮事件
        };

        return oInit;
    };
    function AddFunctions(value,row,index){
        return [
            '<button id="edit" type="button" class="btn btn-default">编辑</button>&nbsp;&nbsp;',
            '<button id="del" type="button" class="btn btn-default">删除</button>'
        ].join("")
    }
    window.operateEvents = {
        "click #edit":function(e,value,row,index){
            $('#uppublishId').selectpicker({
            });
            $('#uppublishId').html("");
            var content = "<option value='-1'>请选择</option>";
            for (var i = 0; i <result.length ; i++) {
                content += "<option value='"+result[i].pubId+"'>"+result[i].pubName+"</option>";
            }
            $('#uppublishId').html(content);
            //初始化刷新数据
            $('#uppublishId').selectpicker('refresh');
            $('#uppublishId').selectpicker('render');
            $('#uppublishId').selectpicker('val',row.publish.pubId);
            $("#bookId").val(row.bookId);
            $("#bookName").val(row.bookName);
            $("#pic").val(row.pic);
            $("#createDate").val(row.createDate);
            $("#preview_photo").attr("src","/upimg/"+row.pic);
            $("#upModal").modal("show");

        },
        "click #del":function(e,value,row,index){
            var r=confirm("确认删除该记录？");
            if(r){
                $.ajax({
                    url:"${path}/bs/doDel",
                    type:"POST",
                    data:{_method:"DELETE", bookId:row.bookId},
                    dataType:"json",
                    success:function(data){
                        $('#table').bootstrapTable("destroy");
                        var oTable = new TableInit();
                        oTable.Init();

                    }

                });
            }

        }
    }
</script>

</body>
</html>
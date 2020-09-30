<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">添加图书</h4>
            </div>
            <form action="${path}/books/bs" method="post">
                <div class="form-group">
                    <label for="bookName">图书名称</label>
                    <input type="text" class="form-control" id="bookName" placeholder="bookName" name="bookName" value="${book.bookName}">
                </div>
                <div class="form-group">
                    <label for="uppublishId">出版社</label>
                    <select class="form-control selectpicker" id="uppublishId" name="publishId">

                    </select>
                </div>
                <div class="form-group">
                    <label for="createDate">出版日期</label>
                    <div class='input-group date' id='datetimepicker1'>

                        <input type='text' class="form-control" name="createDate" id="createDate" value="<fmt:formatDate value='${book.createDate}' pattern='yyyy-MM-dd'></fmt:formatDate>"/>

                        <span class="input-group-addon">
                <span class="glyphicon glyphicon-calendar"></span>
            </span>
                    </div>
                </div>
                <button type="submit" class="btn btn-default">Submit</button>
            </form>
            <script>
                $(function(){
                    $('#datetimepicker1').datetimepicker({
                        format: 'YYYY-MM-DD',
                        locale: moment.locale('zh-cn')
                    });
                    $('.uppublishId').selectpicker({
                    });
                    $.ajax({
                        url:'${path}/bs/pubs',
                        type:'GET',
                        dataType:'json',
                        success:function(data){
                            console.log(data);
                            var content = "";
                            $.each(data,function(i,v){
                                content += "<option value='"+v.pubId+"'>"+v.pubName+"</option>";
                            });
                            $("#uppublishId").append(content);
                        },
                        error:function(msg){
                            console.log(msg);
                        }
                    });
                    //初始化刷新数据
                    $(window).on('load', function() {
                        $('#uppublishId').selectpicker('refresh');
                        $('#uppublishId').selectpicker('render');
                    });
                });
            </script>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
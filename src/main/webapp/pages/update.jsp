<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!-- 模态框（Modal） -->
<div class="modal fade" id="upModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="height: 700px; overflow: auto; pointer-events:auto;">
        <div class="modal-content" >
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">修改图书</h4>
            </div>
            <form action="${path}/bs/doUpdate" method="post" id="myFrm">
                <input type="hidden" name="_method" value="PUT"/>
                <input type="hidden" name="bookId"  id="bookId"/>
                <div class="form-group">
                    <label for="bookName">图书名称</label>
                    <input type="text" class="form-control" id="bookName" placeholder="bookName" name="bookName">
                </div>
                <div class="form-group">
                    <label for="uppublishId">出版社</label>
                    <select class="form-control selectpicker" id="uppublishId" name="publishId">
                            <option value="-1">请选择</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="createDate">出版日期</label>
                    <div class='input-group date' id='datetimepicker1'>

                        <input type='text' class="form-control" name="createDate" id="createDate" />

                        <span class="input-group-addon">
                <span class="glyphicon glyphicon-calendar"></span>
            </span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label"> 科目图片</label>
                    <div class="col-sm-10">
                        <input type="hidden" name="pic" value="" id="pic"/>
                        <input type="file" name="photo" id="photoFile"/>
                        <input type="button" value="上传" id="upload" class="btn-default">
                        <img alt="宣传图片" src="" width="50px" height="50px" id="preview_photo" class="img-circle" style="border:1px solid gray;border-radius: 10px;"/>
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

                });
            </script>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
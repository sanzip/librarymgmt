<div class = "header" id = "bookName">
    ${bookInfos.size() > 0? bookInfos.get(0).book.name : ''}
</div>
<br>
Book No: <g:select class = "ui dropdown" name="bookInfoId" from="${bookInfos}" optionValue="bookNumber" optionKey="id"/><br><br><br>

<div class = "header" id = "bookName">
    ${bookInfos.size() > 0? bookInfos.get(0).book.name : ''}
</div>
<br>
Book No: <g:select class = "ui dropdown" name="bookNumber" from="${bookInfos}" optionValue="bookNumber" optionKey="bookNumber"/><br><br><br>

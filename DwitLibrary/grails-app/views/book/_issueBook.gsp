<div class = "header" id = "bookName">
    <h3>${bookInfos.size() > 0? bookInfos.get(0).book.name : ''}</h3>
</div>
<br>
Book No: <g:select class = "ui dropdown" name="bookNumber" from="${bookInfos}" optionValue="bookNumber" optionKey="bookNumber"/><br><br><br>

    <script type=”text/javascript”>

var intTextBox = 0;

function addElement() {
intTextBox++;
var objNewDiv = document.createElement(‘div’);
objNewDiv.setAttribute(‘id’, ‘div_’ + intTextBox);
objNewDiv.innerHTML = ‘Textbox ‘ + intTextBox + ‘: <input type=”text” id=”tb_’ + intTextBox + ‘” name=”tb_’ + intTextBox + ‘”/>’;
document.getElementById(‘content’).appendChild(objNewDiv);
}

function removeElement() {
if(0 < intTextBox) {
document.getElementById(‘content’).removeChild(document.getElementById(‘div_’ + intTextBox));
intTextBox–;
} else {
alert(“No textbox to remove”);
}
}
</script>
</head>
<body>
<p>Demo of adding and removing textboxes dynamically using simple JavaScript</p>
<p>
    <a href=”javascript:void(0);” onclick=”addElement();”>Add</a>
    <a href=”javascript:void(0);” onclick=”removeElement();”>Remove</a>
</p>
<div id=”content”>

</div>
</body>
</html>
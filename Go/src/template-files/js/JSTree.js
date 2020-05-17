function createJSTree(jsondata) { 
    var divArbol = document.getElementById('JSTree');         
    $(divArbol).jstree({ 'core' : {
        'data' : jsondata
    } });
}

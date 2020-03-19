(function() {
  window.bootstrap = function() {
    return ReactDOM.render(React.createElement(App), document.getElementById("mount_point"));
  };

  window.bootstrap();

}).call(this);

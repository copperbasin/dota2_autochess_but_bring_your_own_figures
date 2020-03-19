(function() {
  window.rel_mouse_coords = function(event) {
    var currentElement, totalOffsetX, totalOffsetY;
    totalOffsetX = 0;
    totalOffsetY = 0;
    currentElement = event.target;
    while (true) {
      totalOffsetX += currentElement.offsetLeft - currentElement.scrollLeft;
      totalOffsetY += currentElement.offsetTop - currentElement.scrollTop;
      if (!(currentElement = currentElement.offsetParent)) {
        break;
      }
    }
    return {
      x: event.pageX - totalOffsetX,
      y: event.pageY - totalOffsetY
    };
  };

}).call(this);

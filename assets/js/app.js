// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

import $ from "jquery"

function createNewBlock() {
  let payload = {
    task_id: window.taskId
  };
  $.ajax("/time_blocks/new", {
    method: "get",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: payload,
    success: (resp) => {
      console.log(resp);
      updatePageWithBlock(resp["data"]);
    },
    error: (resp) => {
      console.log("error!");
      console.log(resp);
    }
  })
}

function updatePageWithBlock(block) {
  $("#startBlock").remove();
  $("#startCell").append("<p>"+block.start+"</p>");
  $("#endCell").append("<button class=\"btn btn-primary\" id=\"startBlock\">Finish</button>");
}

function endBlock(blockId) {
  let payload = { id: blockId }
  $.ajax("/time_blocks/end_block", {
    method: "get",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: payload,
    success: (resp) => {
      console.log(resp);
      //updatePageWithBlock(resp["data"]);
    },
    error: (resp) => {
      console.log("error!");
      console.log(resp);
    }
  })
}


$(function () {
    $("#endBlock").click((ev) => {
      let blockId = $(ev.target).data('block-id');
      endBlock(blockId);
    });

    $("#startBlock").click((ev) => {
      createNewBlock();
    });
});

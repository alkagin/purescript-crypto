"use strict";

var crypto = require('crypto');

exports._createVerify = function (algorithm) {
    return function () {
        crypto.createVerify(algorithm);
    }
}

exports._update = function(verify) {
  return function(data) {
    return function() {
      verify.update(data);
    }
  }
}

exports._verify = function (verify) {
  return function(object) {
    return function(signature) {
      verify.verify(object, signature);
    }
  }
}

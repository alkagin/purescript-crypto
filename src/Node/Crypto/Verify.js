"use strict";

var crypto = require('crypto');

exports._createVerify = function (algorithm) {
  return function () {
    return crypto.createVerify(algorithm);
  }
}

exports._update = function (verify) {
  return function (data) {
    return function () {
      return verify.update(data);
    }
  }
}

exports._verify = function (verify) {
  return function (object) {
    return function (signature) {
      return function () {
        return verify.verify(object, signature);
      }
    }
  }
}

"use strict";

var _sortSetter = _interopRequireDefault(require("./sort-setter"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

describe('sortSetter', function () {
  const defautlFieldName = 'someFieldName';
  const overridenFieldName = 'otherField';
  const overridenDirection = 'desc';
  const resourceOptions = {
    sort: {
      sortBy: overridenFieldName,
      direction: overridenDirection
    }
  };
  it('returns query when it is passed', function () {
    const direction = 'asc';
    const sortBy = 'name';
    expect((0, _sortSetter.default)({
      direction,
      sortBy
    }), defautlFieldName, {}).to.deep.equal({
      direction,
      sortBy
    });
  });
  it('returns defaults when no query is given', function () {
    expect((0, _sortSetter.default)({}, defautlFieldName, {})).to.deep.equal({
      direction: _sortSetter.default.DEFAULT_DIRECTION,
      sortBy: defautlFieldName
    });
  });
  it('returns overriden sort settings when no defaults are given', function () {
    expect((0, _sortSetter.default)({}, defautlFieldName, resourceOptions)).to.deep.equal(resourceOptions.sort);
  });
  it('throws an error when direction is not correct', function () {
    expect(() => {
      (0, _sortSetter.default)({}, defautlFieldName, {
        sort: {
          direction: 'other'
        }
      });
    }).to.throw().property('name', 'ConfigurationError');
  });
});
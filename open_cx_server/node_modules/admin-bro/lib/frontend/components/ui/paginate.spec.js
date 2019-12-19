"use strict";

var _react = _interopRequireDefault(require("react"));

var _reactTestingLibrary = require("react-testing-library");

var _testContextProvider = _interopRequireDefault(require("../spec/test-context-provider"));

var _paginate = _interopRequireDefault(require("./paginate"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

describe('Paginate', function () {
  this.timeout(5000);
  it('renders one element when there should be a 1 page', async function () {
    const location = {
      search: ''
    };
    const {
      findAllByText
    } = (0, _reactTestingLibrary.render)(_react.default.createElement(_testContextProvider.default, null, _react.default.createElement(_paginate.default, {
      page: 1,
      perPage: 10,
      total: 11,
      location: location
    })));
    const el = await findAllByText('1');
    expect(el).to.have.lengthOf(1);
  });
});
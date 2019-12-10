const AdminBro = require('admin-bro');
const AdminBroExpress = require('admin-bro-expressjs');
const AdminBroMongoose = require('admin-bro-mongoose');

const User = require('./models/user');
const Event = require('./models/event');
const Forum = require('./models/forum');
const Participant = require('./models/participant');
const Question = require('./models/question');
const Speaker = require('./models/speaker');
const Talk = require('./models/talk');

AdminBro.registerAdapter(AdminBroMongoose)
const adminBro = new AdminBro({
  rootPath: '/admin',
  resources: [
    {
      resource: User,
      options: {
        properties: {
          name: { isVisible: { list: true, filter: true, show: true, edit: false}},
          tags: { isVisible: { list: true, filter: true, show: true, edit: true}}
        }
      }
    },
    {
      resource: Event,
      options: {
        properties: {
          name: { isVisible: { list: true, filter: true, show: true, edit: false}}
        }
      }
    },
    {
      resource: Forum,
      options: {
        properties: {
          id: { isVisible: { list: true, filter: true, show: true, edit: false}}
        }
      }
    },
    {
      resource: Participant,
    },
    {
      resource: Question,
    },
    {
      resource: Speaker,
    },
    {
      resource: Talk,
    },
  ],
  branding: {
    companyName: 'NeTinder',
    softwareBrothers: false
  },
  actions: {
    new: {
      before: async (request) => {
        if(request.payload.record.password) {
          request.payload.record = {
            ...request.payload.record,
            encryptedPassword: await bcrypt.hash(request.payload.record.password, 10),
            password: undefined,
          }
        }
        return request
      },
    }
  }
})

module.exports = adminRouter = AdminBroExpress.buildRouter(adminBro)

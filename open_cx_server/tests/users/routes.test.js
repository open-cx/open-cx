const supertest = require('supertest')
const app = require('../../app')
const request = supertest(app)

describe('GET /users Endpoint', () => {
    it('makes a GET request to /users', async (done) => {
        const response = await request.get('/users')
    
        expect(response.status).toBe(200)
        done()
    })
})

describe('Post /users/register with missing fields', () => {
    it('should return a 400 Bad Request error', async () => {
      const res = await supertest(app)
        .post('/users/register')
        .send({
          "fullname": "testuser"
        })
      expect(res.statusCode).toEqual(400)
    })
  })

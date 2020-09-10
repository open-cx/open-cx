const supertest = require('supertest')
const app = require('../../app')
const request = supertest(app)

describe('GET /events Endpoint', () => {
    it('makes a GET request to /events', async (done) => {
        const response = await request.get('/events')
    
        expect(response.status).toBe(200)
        done()
    })
})

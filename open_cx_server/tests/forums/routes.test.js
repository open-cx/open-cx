const supertest = require('supertest')
const app = require('../../app')
const request = supertest(app)

describe('GET /forums Endpoint', () => {
    it('makes a GET request to /forums', async (done) => {
        const response = await request.get('/forums')
    
        expect(response.status).toBe(200)
        done()
    })
})

const supertest = require('supertest')
const app = require('../../app')
const request = supertest(app)

describe('GET /questions Endpoint', () => {
    it('makes a GET request to /questions', async (done) => {
        const response = await request.get('/questions')
    
        expect(response.status).toBe(200)
        done()
    })
})

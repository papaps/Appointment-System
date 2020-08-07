const request = require('supertest')
const app = require('../server')
describe('Post Endpoints', () => {
  it('should go to login page', async () => {
    const res = await request(app)
      .get('/login')
      
    expect(res.statusCode).toEqual(200)
  })
  it('invalid path', async () => {
    const res = await request(app)
      .get('/foo/bar')
      
    expect(res.statusCode).toEqual(404)
  })
})
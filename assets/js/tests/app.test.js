import * as React from 'react';
import axios from 'axios';

import {
  render,
  screen,
  fireEvent,
  act,
} from '@testing-library/react';
// import '@testing-library/jest-dom'
// import '@testing-library/jest-dom/extend-expect';


jest.mock('axios');
import App from '../app/app.jsx';

describe('App', () => {
  test('displays home page', () => {
    render(<App />);

    expect(screen.queryByText(/SmolUrl/)).toBeInTheDocument();
  })

  test('displays the create url form if there is no short url already', () => {
    render(<App />);
    expect(screen.queryByText(/Input a long URL to make a SmolURL/)).toBeInTheDocument();
  })

  test('button becomes enabled when a url is entered', () => {
    render(<App />);

    expect(screen.getByText(/Make SmolURL/).closest('button')).toBeDisabled()

    fireEvent.change(screen.getByLabelText('🔗 Input a long URL to make a SmolURL'), {
      target: {
        value: 'https://google.com',
      },
    });

    expect(screen.getByText(/Make SmolURL/).closest('button')).toBeEnabled()
  })

  test('switches to the short url form when a short url is created, and back when Shorten Another is pressed', async () => {
    const resultPromise = Promise.resolve({
      data: {
        long_url: "https://google.com/",
        slug: "sX3fs"
      }
    });

    axios.post.mockImplementation(() => resultPromise);

    render(<App />);

    expect(screen.getByText('Make SmolURL!')).toBeInTheDocument()

    fireEvent.change(screen.getByLabelText('🔗 Input a long URL to make a SmolURL'), {
      target: {
        value: "https://google.com/",
      },
    });

    fireEvent.click(screen.getByText('Make SmolURL!'));

    await act(() => resultPromise);
    expect(screen.getByText('Shorten Another')).toBeInTheDocument()
    expect(screen.getByLabelText('🔗 Your long URL')).toHaveValue("https://google.com/")
    expect(screen.getByLabelText('🪄 SmolURL')).toHaveValue("http://localhost/sX3fs")

    fireEvent.click(screen.getByText('Shorten Another'));

    expect(screen.getByText('Make SmolURL!')).toBeInTheDocument()
    expect(screen.getByLabelText('🔗 Input a long URL to make a SmolURL')).toHaveValue("")

  })
});

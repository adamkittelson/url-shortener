import "../../css/app.css"
import React from "react";
import axios from 'axios';

import UrlCreationForm from './url_creation_form';
import ShortUrlForm from './short_url_form';

const host = window.location.origin + '/';

const useSemiPersistentState = (key, initialState) => {
  const [value, setValue] = React.useState(
    localStorage.getItem(key) || initialState
  );

  React.useEffect(() => {
    localStorage.setItem(key, value);
  }, [value, key]);

  return [value, setValue];
}

const App = () => {
  const [url, setUrl] = useSemiPersistentState('url', '')
  const [slug, setSlug] = useSemiPersistentState('slug', '')
  const [shortUrl, setShortUrl] = useSemiPersistentState('short-url', '')
  const [error, setError] = React.useState('');

  const handleUrlInput = (event) => {
    setUrl(event.target.value);
  };

  const handleSlugInput = (event) => {
    setSlug(event.target.value);
  };

  const handleCreateUrlSubmit = (event) => {
    createUrl();
    event.preventDefault();
  };

  const handleCreateAnother = (event) => {
    setShortUrl('')
    setUrl('')
    setSlug('')
    event.preventDefault();
  }


  const createUrl = async () => {
    try {
      const result = await axios.post(`${host}api`, { long_url: url, slug: slug });

      setShortUrl(`${host}${result.data.slug}`)
      setUrl(result.data.long_url)
    } catch (error) {
      setError(error.response.data.error)
    }
  };

  return (
    <>
      <h1 className="headline-primary">
        <a href={host}>SmolUrl</a>
      </h1>

      <div className="card">
        {shortUrl ? (
          <ShortUrlForm
            longUrl={url}
            shortUrl={shortUrl}
            onCreateAnotherSubmit={handleCreateAnother}
          />
        ) : (
          <UrlCreationForm
            host={host}
            url={url}
            slug={slug}
            error={error}
            onUrlInput={handleUrlInput}
            onSlugInput={handleSlugInput}
            onCreateUrlSubmit={handleCreateUrlSubmit}
          />
        )}
      </div>



    </>
  );
}

export default App;


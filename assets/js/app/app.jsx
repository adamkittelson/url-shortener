import "../../css/app.css"
import React from "react";
import axios from 'axios';

import List from './list';
import UrlCreationForm from './url_creation_form';

const API_ENDPOINT = window.location.origin + '/';

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


  const createUrl = async () => {
    try {
      const result = await axios.post(API_ENDPOINT, { url: url, slug: slug });

      console.log(result)
    } catch {
      console.log(result)
    }
  };

  return (
    <>
      <h1 className="headline-primary">
        <a href={`${API_ENDPOINT}`}>SmolUrl</a>
      </h1>

      <UrlCreationForm
        host={API_ENDPOINT}
        url={url}
        slug={slug}
        onUrlInput={handleUrlInput}
        onSlugInput={handleSlugInput}
        onCreateUrlSubmit={handleCreateUrlSubmit}
      />

    </>
  );
}

export default App;


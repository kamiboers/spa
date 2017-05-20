var IdeaRepository = {
  create: function (idea) {
    return $.post('/api/v1/ideas', {idea: idea});
  }
};
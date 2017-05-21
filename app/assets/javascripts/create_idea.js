var newIdeaTitle, newIdeaBody;

$(document).ready(function () {
  newIdeaTitleInput = $('.new-idea-title');
  newIdeaBodyInput = $('.new-idea-body');

  $('.new-idea-submit').on('click', createIdea);
});

function createIdea(event) {
  event.preventDefault();
  IdeaRepository.create(getNewIdeaInput());
}

function getNewIdeaInput() {
  return {
    title: newIdeaTitleInput.val(),
    body: newIdeaBodyInput.val()
  };
}
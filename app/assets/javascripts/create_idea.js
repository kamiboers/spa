var newIdeaTitle, newIdeaBody;

$(document).ready(function () {
  newIdeaTitle = $('.new-idea-title');
  newIdeaBody = $('.new-idea-body');

  $('.new-idea-submit').on('click', createIdea);
});

function createIdea(event) {
  event.preventDefault();
  console.log(getNewIdea());
  IdeaRepository.create(getNewIdea());
}

function getNewIdea() {
  return {
    title: newIdeaTitle.val(),
    body: newIdeaBody.val()
  };
}
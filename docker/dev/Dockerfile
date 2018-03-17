FROM debian:buster                                               
WORKDIR /root                                                    
                                                                 
RUN apt-get update && apt-get install -y neovim tmux nethack-console git curl astyle ruby-beautify apache2-utils htop ranger gnupg links
                                                                 
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash         
RUN apt-get install -y nodejs                                    
RUN npm install -g js-beautify prettier prettydiff nodemon       
                                                                 
RUN rm /usr/bin/vim                                              
RUN ln -s /usr/bin/nvim /usr/bin/vim                             
                                                                                                                                                                                                                                                                                
RUN git clone https://github.com/chickenninja/OneRepoToRuleThemAll.git                                                                                                                                                                                                          
RUN git clone https://github.com/chickenninja/dotfiles.git

RUN git config --global user.email "sean@example.com"
RUN git config --global user.name "Sean"


RUN mkdir -p ~/.local/share/nvim/site/pack/git-plugins/start && git clone https://github.com/w0rp/ale.git ~/.local/share/nvim/site/pack/git-plugins/start/ale && git clone https://github.com/sbdchd/neoformat.git ~/.local/share/nvim/site/pack/git-plugins/start/neoformat

RUN ~/dotfiles/link.sh

# todo - install lastpass, other cli tools

CMD bash

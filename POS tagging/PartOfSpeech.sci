ZERO = 1

//części mowy
partsOfSpeechList = list(list("rzeczownik",1),list("przymiotnik",2),list("czasownik",3),list("liczebnik",4),list("zaimek",5),list("przysłówek",6),list("przyimek",7),list("spójnik",8),list("wykrzyknik",9),list("partykuła",10))


words = list()
nrOfTaggs = length(partsOfSpeechList)

//prawdopodobienstwa przejsc miedzy stanami
probabilities = zeros(nrOfTaggs,nrOfTaggs) 
for i=1:nrOfTaggs
    for j=1:nrOfTaggs
        probabilities(i,j) = ZERO
    end
end

//prawdopodobieństwa początkowe
p0 = zeros(1,nrOfTaggs)


for e=sentences
    for i = 1:(length(e)-1)
        probabilities(e(i)(2),e(i+1)(2)) = probabilities(e(i)(2),e(i+1)(2))+1
    end
    p0(e(1)(2)) = p0(e(1)(2)) + 1
end

for i=1:10
    if sum(probabilities (i,:))<>0 then
        probabilities (i,:) =  probabilities (i,:)/sum( probabilities (i,:))
    end
end

p0 = p0/sum(p0)

//tworzenie słownika
for i=1:length(sentences)
    for e = sentences(i)
        for f=words
            if e==f then
                break
            end
        end
        words($+1) = e
    end
end
nrOfWords=length(words)

//prawdopodobienstwo, ze dla danego tagga bedzie dane slowo
conditionalProbability = zeros(nrOfWords,nrOfTaggs)    
for i=1:nrOfWords
    for j=1:nrOfTaggs
        conditionalProbability(i,j) = ZERO
    end
end

for i=1:nrOfTaggs
    for j=1:nrOfWords
        if partsOfSpeechList(i)(2)==words(j)(2) then
            conditionalProbability(j,i) = conditionalProbability(j,i)+1
        end
    end
    if sum(conditionalProbability(:,i)) then
        conditionalProbability(:,i)=conditionalProbability(:,i)/sum(conditionalProbability(:,i))    
    end
end


//znajdowanie początkowej sekwencji dla zdania podanego jako lista
function sequence =  findSequence(sentence)
    Y = list()
    for e=sentence
        for i=1:nrOfWords
            if e==words(i)(1) then
                Y($+1) = i
            end
        end
    end
    tab = zeros(1,length(sentence))
    for i=1:length(sentence)
        tab(i) = Y(i)
    end
  sequence = viterbi(tab)
  for i=1:length(sequence)
      disp(partsOfSpeechList(sequence(i)),sentence(i))
  end
endfunction

//algorytm Viterbiego do znajdowania początkowej sekwencji stanów(części mowy)
function X=viterbi(Y)
  A = probabilities
  B = conditionalProbability
  pi = p0
  K = nrOfTaggs
  T = length(Y)
  S = zeros(1,nrOfTaggs)
  T1 = zeros(nrOfTaggs,T)
  T2 = zeros(nrOfTaggs,T)
  maxTab = zeros(1,T)
  z = zeros(1,T)
  X = zeros(1,T)
  for i=1:nrOfTaggs
    S(i) = i
    T1(i,1) = pi(i)*B(Y(1),i)
  end
  for i = 2:T
    for j = 1:nrOfTaggs
      for k = 1:nrOfTaggs
        maxTab(k) = T1(k,i-1)*A(k,j)*B(Y(i),j)
      end
      [T1(j,i),T2(j,i)] = max(maxTab)
    end
  end
  [m,z(T)] = max(T1(:,T))
  X(T) = S(z(T))
  for i = T:-1:2
    [m,z(i-1)] = max(T1(:,i-1))
    X(i-1) = S(z(i-1))
  end
endfunction
  


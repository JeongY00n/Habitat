package com.ssafy.habitat.service;

import com.ssafy.habitat.entity.User;
import com.ssafy.habitat.exception.CustomException;
import com.ssafy.habitat.exception.ErrorCode;
import com.ssafy.habitat.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.intercept.RunAsImplAuthenticationProvider;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserService implements UserDetailsService {

    private UserRepository userRepository;

    @Autowired
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public User getUser(String userKey) {
        User findUser = userRepository.findById(userKey).orElse(null);
        if(findUser == null) { // 존재하지 않는 유저
            throw new CustomException(ErrorCode.USER_KEY_NOT_FOUND);
        }
        return findUser;
    }

    //해당 key가 사용할 수 있는 key인지 판별합니다.
    public boolean userKeyCheck(String newKey) {
        return userRepository.findById(newKey).orElse(null) != null;
    }
    public boolean friendCodeCheck(String newFriendCode) {return userRepository.findByFriendCode(newFriendCode) != null;}
    public boolean socialKeyCheck(String socialKey) {return userRepository.findBySocialKey(socialKey) == null;}

    public User getByFriendCode(String code) {
        User findUser = userRepository.findByFriendCode(code);
        if(findUser ==  null) { // 존재하지 않는 친구코드
            throw new CustomException(ErrorCode.FRIEND_CODE_NOT_FOUND);
        }
        return findUser;
    }

    public User getBySocialKey(String socialKey) {
        User findUser = userRepository.findBySocialKey(socialKey);
        if(findUser ==  null) { // 존재하지 않는 친구코드
            throw new CustomException(ErrorCode.FRIEND_CODE_NOT_FOUND);
        }
        return findUser;
    }

    public User addUser(User user){
        User saveUser = userRepository.save(user);
        return saveUser;
    }

    @Override
    public UserDetails loadUserByUsername(String userKey) {
        System.out.println(userRepository.findById(userKey));
        User getUser = userRepository.findById(userKey).orElse(null);
        UserDetails userDetails = userRepository.findById(userKey)
                .orElseThrow(() -> new CustomException(ErrorCode.USER_KEY_NOT_FOUND));
        return userDetails;
    }

    //아마 필요 없을 듯..?
    private UserDetails createUserDetails(User user) {
        UserDetails makeUser = User.builder()
                .userKey(user.getUserKey())
                .password(user.getPassword())
                .nickname(user.getNickname())
                .roles(user.getRoles())
                .build();
        return makeUser;
    }
}
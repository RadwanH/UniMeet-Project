package entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="users")
public class User {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="UserId")
	private int userId;
	
	@Column(name="Name")
	private String firstName;
	
	@Column(name="Surname")
	private String lastName;
	
	@Column(name="Gender")
	private String gender;
	
	@Column(name="Email")
	private String email;
	
	@Column(name="PhoneNumber")
	private String phoneNumber;
	
	@Column(name="UserBio")
	private String userBio;
	
	@Column(name="UserPassword")
	private String userPassword;
	
	@ManyToOne
	@JoinColumn(name="ID")
	private UniDept uniDept;
	


}

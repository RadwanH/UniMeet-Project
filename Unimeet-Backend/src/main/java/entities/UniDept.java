package entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.CascadeType;

import lombok.Data;

@Data
@Entity
@Table(name="unidept")
public class UniDept {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="ID")
	private int uniDeptId;
	
	@Column(name="UniName")
	private String uniName;
	
	
	@OneToMany(mappedBy="DeptID")
	@Cascade(CascadeType.ALL)
	private List<Department> departments;
	
	
	@OneToMany(mappedBy="UniID")
	@Cascade(CascadeType.ALL)
	private List<University>universities;
	
	
	@OneToMany(mappedBy="UserId")
	@Cascade(CascadeType.ALL)
	private List<User>users;

}

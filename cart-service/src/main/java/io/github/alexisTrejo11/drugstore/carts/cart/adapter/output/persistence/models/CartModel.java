package io.github.alexisTrejo11.drugstore.carts.cart.adapter.output.persistence.models;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Data
@NoArgsConstructor
@Table(name = "carts", indexes = {
    @Index(name = "idx_carts_customer_id", columnList = "customer_id"),
    @Index(name = "idx_carts_created_at", columnList = "created_at"),
    @Index(name = "idx_carts_updated_at", columnList = "updated_at")
})
public class CartModel {
  @Id
  @Column(name = "id", length = 36)
  private String id;

  @Column(name = "customer_id", nullable = false, length = 255)
  private String customerId;

  @OneToMany(mappedBy = "cart", cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true)
  private List<CartItemModel> cartItems = new ArrayList<>();

  // A Set (not a List) is required to avoid MultipleBagFetchException when both
  // cartItems and afterwardItems are eagerly fetched in the same query.
  @Setter(AccessLevel.NONE)
  @OneToMany(mappedBy = "cart", cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true)
  private Set<AfterwardModel> afterwardItems = new LinkedHashSet<>();

  @Column(name = "created_at")
  private LocalDateTime createdAt;

  @Column(name = "updated_at")
  private LocalDateTime updatedAt;

  public CartModel(String id) {
    this.id = id;
  }

  @PrePersist
  public void onCreate() {
    createdAt = LocalDateTime.now();
    updatedAt = createdAt;
  }

  public List<CartItemModel> getCartItems() {
    return Collections.unmodifiableList(cartItems);
  }

  public Set<AfterwardModel> getAfterwardItems() {
    return Collections.unmodifiableSet(afterwardItems);
  }

  public void setAfterwardItems(Collection<AfterwardModel> afterwardItems) {
    this.afterwardItems = afterwardItems != null ? new LinkedHashSet<>(afterwardItems) : new LinkedHashSet<>();
  }

  @PreUpdate
  public void onUpdate() {
    updatedAt = LocalDateTime.now();
  }

}

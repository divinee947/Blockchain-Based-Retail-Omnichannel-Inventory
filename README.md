# Blockchain-Based Retail Omnichannel Inventory System

A decentralized solution for retail inventory management across multiple channels using Clarity smart contracts on the Stacks blockchain.

## Overview

This system provides a comprehensive solution for retailers to manage their inventory across multiple channels (online, in-store, warehouses) using blockchain technology. The system consists of five core smart contracts that work together to create a transparent, secure, and efficient inventory management system.

## Smart Contracts

### 1. Store Verification Contract (`store-verification.clar`)

Validates and manages retail locations:
- Register new store locations
- Verify store authenticity
- Track store metadata
- Query store verification status

### 2. Product Registration Contract (`product-registration.clar`)

Records merchandise details:
- Register new products with detailed information
- Manage product SKUs with pricing and attributes
- Activate/deactivate products
- Query product information

### 3. Inventory Tracking Contract (`inventory-tracking.clar`)

Monitors stock levels across all locations:
- Initialize inventory for products at specific stores
- Add or remove inventory with full audit trail
- Check inventory availability
- Track inventory changes over time

### 4. Allocation Contract (`allocation.clar`)

Manages distribution of inventory between locations:
- Create allocation requests to move inventory
- Approve or reject allocation requests
- Track allocation status
- Complete allocations after physical transfer

### 5. Fulfillment Contract (`fulfillment.clar`)

Tracks order processing:
- Create customer orders
- Add items to orders
- Update order status through the fulfillment process
- Query order details and status

## System Architecture

The contracts are designed to work together:

1. Stores are registered and verified in the Store Verification Contract
2. Products are registered in the Product Registration Contract
3. Inventory is tracked for each product at each store in the Inventory Tracking Contract
4. Inventory is moved between stores using the Allocation Contract
5. Customer orders are fulfilled using the Fulfillment Contract

## Security Features

- Admin-only functions for sensitive operations
- Comprehensive error handling
- Audit trails for inventory changes
- Status tracking for orders and allocations

## Getting Started

### Prerequisites

- Stacks blockchain development environment
- Clarity language knowledge

### Deployment

1. Deploy the contracts in the following order:
    - Store Verification Contract
    - Product Registration Contract
    - Inventory Tracking Contract
    - Allocation Contract
    - Fulfillment Contract

2. Initialize the system:
    - Register stores
    - Register products
    - Initialize inventory

## Testing

Run the test suite using Vitest:

```bash
npm test

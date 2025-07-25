# Delta-Neutra GMX-v2 Vault


This repository is my submission for the Cyfrin GMX Challenge. By building and demonstrating this delta-neutral funding fee farming vault on GMX v2.

---

## Project Purpose

This project implements a vault that systematically earns funding fees from GMX's decentralized perpetuals exchange. The strategy is delta-neutral, meaning the position is not affected by ETH price movements—profit comes from funding fees, not speculation.

---

## Core Strategy

- **Delta-Neutral Position:**  
  The vault shorts ETH using ETH as collateral at 1x leverage, making the position price-neutral.
- **Funding Fee Farming:**  
  The vault enters positions only when funding rates favor shorts (longs pay shorts), capturing funding fees as yield.
- **Automated Management:**  
  The vault monitors funding rates, manages positions, and tracks costs (borrowing, price impact) to maximize net profit.

---

## Quick Start

1. **Clone & Install**
   ```sh
   git clone <repo-url>
   cd delta-neutra
   forge install
   ```

2. **Configure Environment**
   Create a `.env` file in the project root:
   ```
   FORK_URL=
   FORK_BLOCK_NUM=351699610
   ```

3. **Build & Test**
   ```sh
   forge build
   forge test
   ```

---

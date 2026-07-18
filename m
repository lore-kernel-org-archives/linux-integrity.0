Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9A32BE7AC
	for <linux-integrity@vger.kernel.org>; Sat, 18 Jul 2026 06:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784357537; cv=pass; b=fxP0PjIJo7k+FpPSX+1I77BpgkfcNle6tofHRkm1oZxj8Jn/AnBOb6H0HvCuB1m5HWKqPtNHeTn3tkYrc5M+wCOMR1JWE6Zo5omS98ZQY+SmeQHzkLDJ09KWTgQQ4jIkR/iy0eGm6G6debeSC2+KuI7dyBEbqUi/3VFbrry6Z6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784357537; c=relaxed/simple;
	bh=OMsuE+SXJbt52iZeChlnxwlOKtWfDRtiM6XVH9hfCAo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Vsyw01+FHQLeq1va0Py48sCU/ARsR/eK7VjKy9//sVDZifZdNLK6vkMbZMrH93vhVkcO0mZs3SDoeVWN7ZOdrqJk1q9x0jEg0o+wk+LWFjOoZ9uE0EwNGdz9/Gyx3RpSBnuJj3kALSTJHbG9Tlk2D/DK9tCJ3Pvq3xw8wFK3Hi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=tPC60XMq; arc=pass smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="tPC60XMq"
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 05A313FBBA
	for <linux-integrity@vger.kernel.org>; Sat, 18 Jul 2026 06:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1784357532;
	bh=bGn30bLShXuMhmKRFYNkrQvCNUmHLHsw4a9juH5wMKY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
	b=tPC60XMqxwddjDOAFcO4rYH6RAzErOzD/r8sqcXnTLjPY9BnmTOz0zk7vxeM7gCHj
	 kW2J3EQpC9KrjsqzG7yqKPbCCmgnO/bUV250aQ8g9MeHCFUQbu6/GIHAUBrgYln7fk
	 PYMQzUHT4oWCZOtW5GryuO1GCqKUWAhuypzrDQbYW4N2dQne6BuQsytXs1oIaDhTnD
	 XTs4QynYr3toepPt7A7FaY4vUIqHmpzFYNIe8ci3OcyAOA+D/7Wai0tDpTh6aKyP9k
	 NuRs9aNcslIP5TUl+Or+9Mt065B82nKnPFPxoDvbxP2GzRulr7KOk7ntE8JQa/W3pF
	 nLvjRCRJrsa90axvIHY+BUPNmMv3z3KgL8qlnVIQui2Zq421x/5b/Un0MY2VNwsBv5
	 Gt4aQfJxIKdsFoXFNCudrxK5BGhWfqWIg8PwI4MoHRKLlrh4btZIT3SteV0SHLtRhy
	 e6VZ9+EPP/AtjcM5NXTsw5uMLEe6Dpk3f6XBehb1FoFlqcNRoEWYek7escXDAoqnAz
	 nOPsWhWYQ8YEdLEO3O0prO0yOD07g5831d+aOMvP9o8GwDYYzwhMdn/ZaYHYPnISwt
	 e4EMPZRQvD7euykM0kpRVDM/ir5Q5FzpY0bgkvuog/F1SDN87jN/CgeXhs9o3bBGwZ
	 Ose9CtKWwYorJjwZyUOpogvM=
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47345535410so8304204f8f.1
        for <linux-integrity@vger.kernel.org>; Fri, 17 Jul 2026 23:52:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784357531; cv=none;
        d=google.com; s=arc-20260327;
        b=cueXIMzHs2aZXoJdCEM3bZ+MRx1zPvE3FUKiJr5jfutbIvEgVfY33ySEYB0Y2DlfSa
         4x7/ketMjAWubfi9NlopqqA4R+jGSjwcn+qtpN0WpDQSRUial3eJR9P+4zAb/D6Ruqvn
         U/wTG6adDhnVkF2jLeq7ZTnWpXP+SJnOotZu25nUgaer1pAn5VmPntc9R2KSu0vrMnzM
         b+Kqch6guWGlEt2Td+sscHkpXczj+iZD8HAX0LWGxf5wnlUXlOdS3IaHmqFdcXpy3Y+9
         3bVQlcwmLgZSOh3aB7W3qtUyBP8lKehBft2yw1nCacGMoLSAaeL3sAQsB5eeHHOwEXRE
         tK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version;
        bh=bGn30bLShXuMhmKRFYNkrQvCNUmHLHsw4a9juH5wMKY=;
        fh=ZYeds32+lf9vn+Ai9d6spxvb4MxzPtQB6lbY8QWIzXg=;
        b=aRKaUFp6xOQVWSfDhGT5TqI8q999t/J5f8QtXL2Y5+vlE3GNM5v6CRd/hBrnY64yZs
         mJVvoM229uJq+dbLzv5B8b5r1Uvw6npQNBXn1C1LhfJHZ2DwvG5zoFSGe3QCIUJ4xmW9
         r6Ealez9j0isWcjaaCnutY7R0o89yJ0U0WvCgneJiOd1qXYLE4/4jEZvBcd4/s3qrMRp
         lrTaWq5ZjQASKgGaixw7UO0Fou/7X9Lyy000aVQUNDU7qws/qhBlc7/o1VXpNRipXLyc
         C05x0efOn3DWbeHWSEuVBKPTI9FuQeT5C9+0jiwNRdlrvrtsZ/wKklmvWgA7Zjs52/UX
         PORQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784357531; x=1784962331;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bGn30bLShXuMhmKRFYNkrQvCNUmHLHsw4a9juH5wMKY=;
        b=dMqHb/jeN9x7e2rOm/iSnHJhb+ec0K8hb3CxEOBwIixtW/ACXNsT+ebcWmofLi0Kr8
         Ax0QFsJo6Q5QFA6axwwz35Csra/bMa6wcHN8S5J8PsQmjj4t2OmtHBSNx/Ir0Ij3+mdo
         CAU+xBD8kfrrKu/WYASVVskCxF6Swn6DY2ZjyVza+4zd4b9kqlL+4SIla+s24qQxXDYT
         VC12aHSSDsdSNLEdmlF7aTAE8rQaJp8s+gER2BRGswMsIFoNXOGEXBegQthvfmX0xBPW
         5dz4pG37jmor5atOmDrwGHI6jBwf0zLX2KX0qZqOFUAKRUggM3vsNE/HwSEJZaVf9PxC
         iUlg==
X-Gm-Message-State: AOJu0YzchBa+HVxYjNI7WsLzVVlazJzUGasr9fz1SslDyhrPKlsm+0jr
	G7liGmeiQo0BNc0EhZZ9m13kfGGgw8Mewus5OW50OL1v6PLWB7IHlpAaiyLBDC1gypXAjryCscb
	+70eigRfwk/Mps9UT1osvWPTV2YlXMnDMvzppVE9iP0nxrdb8jFcP9/XDjKL6VBC+SzYL39J/cB
	yX7bNDd7NjOSWuf2b2iInjVL1rpqYvwd5peAKyBumBc+TxCtlxPy9jVt/kPqX1/JRtQJHCU30=
X-Gm-Gg: AfdE7ck+nyOjQ9VoP1DoMSE17odR0qSVKUWdoT5Y6hM/bl4zLrQZRKQg94kxgPkHxkq
	1E+5Hqkwajh7CYlhz9tvSZICe7bxbQiwqI0OIzN7dagA/44un6DrkHLFlwbn6z0Mhvj8Cobtng3
	bh7m6ObvxbrLD01gQyvVOpJd0t3KeMbC993WK1fRS0tzHKLuG/6d5YW2WhH8zIPYzqcNiafk7LB
	C6mF1Ywm/G/vtI9yw==
X-Received: by 2002:a05:6000:2084:b0:47e:4379:a4fd with SMTP id ffacd0b85a97d-47f6230e6e8mr6664064f8f.19.1784357531322;
        Fri, 17 Jul 2026 23:52:11 -0700 (PDT)
X-Received: by 2002:a05:6000:2084:b0:47e:4379:a4fd with SMTP id
 ffacd0b85a97d-47f6230e6e8mr6664035f8f.19.1784357530809; Fri, 17 Jul 2026
 23:52:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Fabrice Derepas <fabrice.derepas@canonical.com>
Date: Sat, 18 Jul 2026 08:52:00 +0200
X-Gm-Features: AUfX_mwR5oByHp3QGjzNWTlgfoKb15BE023Y2RlgnDef2-AWkEAnpxtrVPSv76w
Message-ID: <CAD2AHCbuQyKwR27hNcYRhU7njCeigmQoL9x9i25zb0N5-8Kx+A@mail.gmail.com>
Subject: zohar@linux.ibm.com, roberto.sassu@huawei.com
To: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

evm_read_protected_xattrs() accepts a buffer_size parameter but never
validates it on the 'n' (names) and 'l' (lengths) paths.  The sole
in-tree caller, ima_eventinodexattrs_init_common(), uses a lock-free
measure-then-allocate-then-fill pattern across two separate calls.  A
concurrent write to /sys/kernel/security/integrity/evm/evm_xattrs
between the measure and fill calls causes the fill to iterate more
xattr entries than the buffer was sized for, producing a heap write
past the end of the allocation.


Affected code
-------------
security/integrity/evm/evm_main.c, evm_read_protected_xattrs(),
lines 374-425.

The 'n' path writes at line 395 without checking total_size + size
<= buffer_size.  The 'l' path stores a u32 at line 404 with the same
omission.  The 'v' path at line 413 correctly passes
(buffer_size - total_size) to __vfs_getxattr(), so the omission on
the other two paths is inconsistent with clear design intent:

switch (type) {
case 'n':
size = strlen(xattr->name) + 1;
if (buffer) {
if (total_size)
*(buffer + total_size - 1) = '|';

memcpy(buffer + total_size, xattr->name, size); /* line 395 -- no
bounds check */
}
break;
case 'l':
size = sizeof(u32);
if (buffer) {
if (canonical_fmt)
rc = (__force int)cpu_to_le32(rc);

*(u32 *)(buffer + total_size) = rc;              /* line 404 -- no
bounds check */
}
break;
case 'v':
size = rc;
if (buffer) {
rc = __vfs_getxattr(dentry,
d_backing_inode(dentry), xattr->name,
buffer + total_size,
buffer_size - total_size);               /* line 413 -- has bounds check */
if (rc < 0)
return rc;
}
break;


Root cause
----------
Two defects combine:

(1) Missing bounds check (function-level): the 'n' and 'l' paths write
    into buffer + total_size without verifying total_size + size <=
    buffer_size.  The buffer_size parameter is accepted but unused on
    these paths.

(2) TOCTOU race (caller-level): ima_eventinodexattrs_init_common()
    in ima_template_lib.c:703 calls evm_read_protected_xattrs() twice,
    separated by a kmalloc():

        line 713: rc = evm_read_protected_xattrs(..., NULL, 0, ...);
        line 718: buffer = kmalloc(rc, GFP_KERNEL);
        line 722: rc = evm_read_protected_xattrs(..., buffer, rc, ...);

    list_for_each_entry_lockless() provides RCU read-side traversal but
    does not stabilise the list across two separate calls.  A concurrent
    list_add_tail_rcu() in evm_write_xattrs() (evm_secfs.c:263) between
    lines 713 and 722 causes the fill call to see more entries than the
    buffer accommodates.

    Note: xattr_list_mutex (evm_secfs.c:24) is held only by the writer;
    there is no read-side lock that would prevent the list from changing
    between the two calls.

Neither defect alone is exploitable: without the race, buffer_size
equals the measured size; without defect (1), an overflow would be
caught.  Together they produce a controlled heap write past the
allocation.


Reachability
------------
Write path: evm_write_xattrs() (evm_secfs.c:179) handles writes to
/sys/kernel/security/integrity/evm/evm_xattrs.  It requires
CAP_SYS_ADMIN and evm_xattrs_locked == 0 (checked at line 188).
This path is only compiled when CONFIG_EVM_ADD_XATTRS=y.

Read path: ima_eventinodexattrs_init_common() is called during IMA
event logging for templates that include xattrnames or xattrlengths
fields (e.g. a custom template with 'n' or 'l' fields).  This runs
on any file access (open, exec, mmap) matched by the active IMA
policy.

Concrete scenario:

  1. IMA policy active with a template including xattrnames ('n').
  2. Initial xattr list: security.selinux (17+1 bytes),
     security.ima (12+1 bytes) -- measure call returns 31.
  3. kmalloc(31) allocates the buffer.
  4. CAP_SYS_ADMIN process writes security.apparmor and
     security.capability to evm_xattrs before the fill call.
  5. Fill call iterates 4 entries, needs ~62 bytes -- overflows
     the 31-byte allocation.

The attacker controls write timing and can trigger IMA measurements
on demand (e.g. by opening a file matching the IMA policy), making
the race window practically reliable.


Reproducer
----------
The following reproduces the race by simulating the list growth
between the two calls.  Tested with gcc -fsanitize=address.

  /*
   * repro_evm_oob.c
   * Compile: gcc -fsanitize=address -g -o repro_evm_oob repro_evm_oob.c
   * Run:     ./repro_evm_oob
   */
  #include <stdint.h>
  #include <stdlib.h>
  #include <string.h>
  #include <stdio.h>

  typedef uint32_t u32;

  struct xattr_entry {
      const char *name;
      int         xattr_size;
      struct xattr_entry *next;
  };

  static struct xattr_entry *xattr_head = NULL;

  static void add_xattr(const char *name, int sz)
  {
      struct xattr_entry *e = malloc(sizeof(*e));
      e->name = name; e->xattr_size = sz; e->next = NULL;
      if (!xattr_head) { xattr_head = e; }
      else {
          struct xattr_entry *p = xattr_head;
          while (p->next) p = p->next;
          p->next = e;
      }
  }

  /* Mirrors evm_main.c:374-425 for type='n'. buffer_size is accepted
   * but never checked -- the bug. */
  static int evm_read_protected_xattrs_sim(uint8_t *buffer,
                                           int buffer_size, char type)
  {
      struct xattr_entry *xattr;
      int rc, size, total_size = 0;

      for (xattr = xattr_head; xattr; xattr = xattr->next) {
          rc = xattr->xattr_size;
          if (rc < 0) continue;
          switch (type) {
          case 'n':
              size = strlen(xattr->name) + 1;
              if (buffer) {
                  if (total_size)
                      *(buffer + total_size - 1) = '|';
                  /* BUG: no check that total_size + size <= buffer_size */
                  memcpy(buffer + total_size, xattr->name, size);
              }
              break;
          default:
              return -1;
          }
          total_size += size;
      }
      return total_size;
  }

  int main(void)
  {
      /* Initial list: 2 entries */
      add_xattr("security.selinux", 42);
      add_xattr("security.ima", 32);

      /* Measuring call (buffer=NULL) */
      int measured = evm_read_protected_xattrs_sim(NULL, 0, 'n');
      printf("[1] measured=%d\n", measured);

      uint8_t *buf = malloc(measured);
      if (!buf) return 1;

      /* TOCTOU: list grows before fill call */
      add_xattr("security.apparmor", 100);
      add_xattr("security.capability", 20);

      /* Filling call -- overflows */
      printf("[2] filling...\n");
      int rc = evm_read_protected_xattrs_sim(buf, measured, 'n');
      printf("[3] wrote %d into %d-byte buffer\n", rc, measured);

      free(buf);
      return 0;
  }

Observed ASan output:

  ERROR: AddressSanitizer: heap-buffer-overflow on address 0x...
  WRITE of size 18 at 0x... thread T0
      #0 in memcpy ...
      #1 in evm_read_protected_xattrs_sim repro_evm_oob.c
      #2 in main repro_evm_oob.c

  0x... is located 0 bytes after 30-byte region [0x..., 0x...)
  allocated by thread T0 here:
      #0 in malloc ...
      #1 in main repro_evm_oob.c


Impact
------
Heap write past an allocation.  The attacker chooses the xattr names
(write content) and the number of entries added (write size).
Consequence ranges from a kernel crash (DoS) to, with heap layout
control, a potential privilege escalation.

Requirements: CAP_SYS_ADMIN (to write evm_xattrs), CONFIG_EVM=y,
CONFIG_IMA=y, CONFIG_EVM_ADD_XATTRS=y, and an active IMA policy
with a template containing xattrnames or xattrlengths fields.
CAP_SYS_ADMIN inside a user namespace may suffice on configurations
that permit it.


Proposed fix
------------
Add bounds checks to the 'n' and 'l' paths, mirroring the existing
check on the 'v' path:

--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -388,6 +388,8 @@
  case 'n':
  size = strlen(xattr->name) + 1;
  if (buffer) {
+ if (total_size + size > buffer_size)
+ return -ERANGE;
  if (total_size)
  *(buffer + total_size - 1) = '|';

@@ -398,6 +400,8 @@
  case 'l':
  size = sizeof(u32);
  if (buffer) {
+ if (total_size + size > buffer_size)
+ return -ERANGE;
  if (canonical_fmt)
  rc = (__force int)cpu_to_le32(rc);

A note on the return value: I have used -ERANGE rather than
returning total_size (partial bytes written).  The caller in
ima_eventinodexattrs_init_common() treats negative returns as an
error and falls through to kfree(buffer) without logging partial
data, which is a safer failure mode than silently recording a
truncated xattr list.  The TOCTOU race that triggers the overflow
is also an integrity anomaly (the xattr list changed under us), so
treating it as an error rather than silently truncating seems
correct.  Maintainer preference on the return value is welcome.

An alternative fix at the caller level would be to hold
xattr_list_mutex around both calls in
ima_eventinodexattrs_init_common(), but this requires exposing the
mutex and the function-level bounds check is more robust against
future callers.


How this was found
------------------
Found by applying the Squeeze Loop strategy ("The Squeeze Loop
Strategy: Catching Coherent-and-Wrong Artifacts with an
Author-Independent Executable Oracle," Zenodo DOI 10.5281/zenodo.20787816,
2026) on its C terrain - the deductive-verification analogue of
the paper's Rust application.

Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>

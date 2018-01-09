Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:50748 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbeAIJcZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Jan 2018 04:32:25 -0500
Date: Tue, 9 Jan 2018 12:32:17 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: dmitry.kasatkin@gmail.com
Cc: linux-integrity@vger.kernel.org
Subject: [bug report] ima: re-introduce own integrity cache lock
Message-ID: <20180109093217.hvh7ouly7hqzbxxl@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hello Dmitry Kasatkin,

The patch 0d73a55208e9: "ima: re-introduce own integrity cache lock"
from Dec 5, 2017, leads to the following static checker warning:

	security/integrity/ima/ima_main.c:309 process_measurement()
	error: we previously assumed 'iint' could be null (see line 209)

security/integrity/ima/ima_main.c
   207          if (action) {
   208                  iint = integrity_inode_get(inode);
   209                  if (!iint)
                            ^^^^^
Check for NULL

   210                          rc = -ENOMEM;
   211          }
   212  
   213          if (!rc && violation_check)
   214                  ima_rdwr_violation_check(file, iint, action & IMA_MEASURE,
   215                                           &pathbuf, &pathname, filename);
   216  
   217          inode_unlock(inode);
   218  
   219          if (rc)
   220                  goto out;

[ snip ]

   302  out:
   303          if (pathbuf)
   304                  __putname(pathbuf);
   305          if (must_appraise) {
   306                  if (rc && (ima_appraise & IMA_APPRAISE_ENFORCE))
   307                          return -EACCES;
   308                  if (file->f_mode & FMODE_WRITE)
   309                          set_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
				                           ^^^^^^^^^^^^^^^^^^
Potential NULL dereference?  I'm not sure...

   310          }
   311          return 0;
   312  }

regards,
dan carpenter

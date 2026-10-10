Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1AC38F95B;
	Sat, 10 Oct 2026 23:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791676512; cv=none; b=QRjEEFqlApC13EKNicsmZZqkihZklQhUihhSr7FQFV6WcReCrPQ3wgRBnelFQPnOqLdgDqD6p+XzRG2SWw9gujZN7bpfgUEQf608QIUp2N67xbzLyKzUNPngAvVq8W/hKzxKWYTx9h6iDcOSftlWtt+AuMxLqkqTww1F0mBob0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791676512; c=relaxed/simple;
	bh=C68EYVZPHOktkjrMfz8n7fGuS/msquYG1LZDZMspIog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M1Yl5YzLYuAROAueQZp7DvyjKfSBDk63UsgjWm5y+XD2H2C1vAx7/zRBYmaWAkq54vMsZJqAKfRC7BRFbw22dXL6thQT/MU3mDt9z8NAPzqzGvgDfxo4mTf0h8yHnb0qGIYfi86VEixEXNijxGCk7ioivaaludLqU6ai7g14nlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJq9t/LC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJq9t/LC"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C0DC31F000FF;
	Sat, 10 Oct 2026 23:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791676511;
	bh=+OEPu5CV+a87Nc9M8HQJGoNGLWYj6EzswkKbQpKATH0=;
	h=From:To:Cc:Subject:Date;
	b=bJq9t/LCTD6GhMUhAdOtma1a9AS/hRYn5BruJkkSHcapAs3TswnHkpJcZFD31CWol
	 VW1eJDySbQg2iKuO+qys6gU2uSY4rnrNjxjGFa88X41PyngQDAelfeQ5PRCUwz0wUd
	 K5db9AoeeEAuJ3VlyzmhjwTrWbseXWo/TStQ2csQWAydvTAH6X+ae8Zowftjtczs7y
	 HizvnozaqE4YuWc/OktCQKeclO1B7pCQ0+3gFSUQOze3rmx3E/GHv0yGvvWBwQ2nmg
	 /Z/wFfEKZRQelpztCat0f97+pXLamCRCHrNvE59DJfq1Hr9nigvyg9JxFVoyaEMM0R
	 HlgD8sl/qmvag==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Chu Guangqing <chuguangqing@inspur.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tpm_crb: Remove dead code from crb_map_res()
Date: Sun, 11 Oct 2026 02:54:57 +0300
Message-ID: <20261010235500.2915629-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In all the pre-existing call sites both @iomem and @iobase_ptr are either
both NULL or have a valid address.

Add an invariant for the expeced conditions and remove a dead basic block.
The second block is dead given that if @iomem turns out not to be NULL,
neither can't be @iobase_ptr.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
- Updated the commit message in order to clarify things better.
- Updated the invariant in order to address checkpatch.pl --strict
  errors.
 drivers/char/tpm/tpm_crb.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index ceb4100ba400..833226966fa2 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -570,15 +570,12 @@ static void __iomem *crb_map_res(struct device *dev, struct resource *iores,
 	if (start != new_res.start)
 		return IOMEM_ERR_PTR(-EINVAL);

+	if (!iores != !iobase_ptr)
+		return IOMEM_ERR_PTR(-EINVAL);
+
 	if (!iores)
 		return devm_ioremap_resource(dev, &new_res);

-	if (!*iobase_ptr) {
-		*iobase_ptr = devm_ioremap_resource(dev, iores);
-		if (IS_ERR(*iobase_ptr))
-			return *iobase_ptr;
-	}
-
 	return *iobase_ptr + (new_res.start - iores->start);
 }

--
2.47.3


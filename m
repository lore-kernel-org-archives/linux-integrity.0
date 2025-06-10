Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75B6266F00;
	Tue, 10 Jun 2025 21:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749589959; cv=none; b=F05fiaTCC1ZCT/88adTWI1tYw3I+04rB+VS4sZE92GU75vLihe/81DOq8HOn4HX5LHcQBf9EYMq+lvx2gbLQh/D6RaMi7zeBQK85VJ5dimZoE43+DgZp8iU/xQ5O8Dn5uNxI8E3uxNSbjM/JgcBQt8VrFi5vvYuYRzNHPq+dmRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749589959; c=relaxed/simple;
	bh=PHvbbQYWalKyS772aKIX5CYnmBCTufJHUXqmULUmhM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KahxfXkLHrZGma2uqL8a3pXGF41QxwUJB4PPZt+3pS0SOG9Jv/JwdkUlZYM+5duoXY2q2m/DNOdbRF1QdfEV5cz8o8arafWEee740qaKaefZhb59199YyhReGIgJ3VFvDYuDfQOiNpSYcz1AosNX3NDVcQcD4LIPiooxMktOZYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E898168F;
	Tue, 10 Jun 2025 14:12:16 -0700 (PDT)
Received: from u103485.austin.arm.com (u103485.arm.com [10.118.30.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A10713F66E;
	Tue, 10 Jun 2025 14:12:35 -0700 (PDT)
From: Prachotan Bathi <prachotan.bathi@arm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/1] tpm_ffa_crb: handle tpm busy return code
Date: Tue, 10 Jun 2025 16:12:25 -0500
Message-ID: <20250610211226.3837372-1-prachotan.bathi@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aEdLc_OpTNvsk5pl@kernel.org>
References: <aEdLc_OpTNvsk5pl@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jarkko
Replying again, since the last email was rejected due to html content.
This is building on top of commit a85b55ee64a5da58c6e2c69e2648023189210eae.
A tpm service can be accessed by the driver using direct message request v2
 interface according to chapter 3.3, TPM Service Command Response Buffer
 Interface Over FF-A specificationi v1.0 EAC.
Best
Prachotan

Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DE643635F
	for <linux-integrity@vger.kernel.org>; Tue, 20 Jan 2026 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917583; cv=none; b=UoR8HEp/JXyQPlAhRtHvtWjHTH9ZRuqDmxxo9L08RS10fBADNsBoruAA2U1UVte//PWHICqAvV4h6wJ/BiVmnPM6V6bHrWLubZ8h6n4KP5i9xaQzddLxhmXhAXOJTWq4qMiUX0VAaLi9dIBG/qyq6//b1FrRZ6csZ7pA08uLJR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917583; c=relaxed/simple;
	bh=MZLlj89gqpTb7ycEx8pHBPnP6NEU606k+q6g0k+g8KM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=pRTJZAKoiMYlRhl25b5cqxDORWYe+QloxmZATLn4bbe1aY9yJSIbKS9qr6z0LKx4dWUGOLPHV0qWwhfUSx1P9ZDGSSYFkwR6iHTtCOzlg/d7fkVIPuE5s6o4IMpQGUH4I5mVajET2k758O9XI4iQhR1XTsHqlK6tQEnvxbPGcRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rNq8Newx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rNq8Newx"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60K4AXpg006617;
	Tue, 20 Jan 2026 13:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:subject:to; s=pp1; bh=ZXE648pemSFDtVabFchm9P/4dW/g1ID/izLKTf5B6
	vc=; b=rNq8Newxcz7Ue6YKfsbchKcHvC7m/oYjQ+lAj4OgGj4MRRiw+46XFJCtD
	MN1R0JDDE2uSLN6B3H0ja734ATR3KR5iAMBA4ILgijs+fTAaDsBR2HO6g78daTA0
	m1abQCGAs5RI0sUD1Rc4JSvOjcuBAwK13dA85MZyJvGg1th5UkH/7uYmBmHVYAi4
	P8efyR9k8d6vv5iYaOiH5SJ/zHZWgzYorIZymNR/dA0whxC0FJAH8wgXx1RAksRO
	7aybzEHEAK0SrTQ7L2v9aFyuaAdUJtIR+6ZoIAgfMLPTkQqIQHB5QQjI1ZxUbgwB
	RVugK4/jTPGiEF/Fu5w0aB2wJ0OdA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br0ufd93d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 13:59:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60KBXfX0006451;
	Tue, 20 Jan 2026 13:59:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brqf1cvwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 13:59:38 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60KDxYQj44302842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 13:59:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A61452004E;
	Tue, 20 Jan 2026 13:59:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 941E220043;
	Tue, 20 Jan 2026 13:59:34 +0000 (GMT)
Received: from localhost (unknown [9.52.203.71])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Jan 2026 13:59:34 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: coxu@redhat.com
Cc: hca@linux.ibm.com, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 0/3] Make detecting the secure boot status integrity-wide
In-Reply-To: <20260115004328.194142-1-coxu@redhat.com>
Date: Tue, 20 Jan 2026 14:59:33 +0100
Message-ID: <87zf681j22.fsf@li-0ccc18cc-2c67-11b2-a85c-a193851e4c5d.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CVdKRx29GLGpfeFgiXRWnleQNjNmZ3wf
X-Proofpoint-ORIG-GUID: CVdKRx29GLGpfeFgiXRWnleQNjNmZ3wf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDExNCBTYWx0ZWRfX562UCNGLeQlH
 TMuXYrYwqrhn9HsRGKt2PRqWf7D7wS8Pmr+pcXjazQ+qfvceRqsnNNNz4QvLYfXnn+kffI/FLge
 opzJ4BtbdVKxFitWHRiE2jN/zdKRKQpdGebT3DqlSEOD1AtC7bwCvOMo4DumrKQjxpRaBrHasUe
 M6kp754sW5sc+fLtn9ys8nJ5TtnsQCLu/TThB55SEC5dkOmzK20zTUhdbii7UpQgCnwEjP32DUV
 tbm0jmaV+U8rUg5sb2V2q2IKHHYqDT5ZoIaskA0w/1r9xpmqI6TdsVBmEoGcu24KP5S1pcrqpf5
 pwl7Tiv9zDLhiSRbpOBELun3xX0rRhHKmqUaSI7xtc8iVplQhgYR3MlxN+QQ/OiJKNzwoVP5XsU
 n7utLLm6Yzw6HQEZpNixtDENyIVwGCuXYR5p9s+/rV8oKPnq9LGRLQILZY7dxuQTz/khjz5BIdk
 dfpcG85W4adE6p/aFFQ==
X-Authority-Analysis: v=2.4 cv=bopBxUai c=1 sm=1 tr=0 ts=696f8a4b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=HeZn7uv481eM_KI_4ikA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_03,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601200114


Tested the entire patch series with s390 (with _and_ without secure boot),
and everything seems to work as expected.

Tested-by: Alexander Egorenkov <egorenar@linux.ibm.com> 
